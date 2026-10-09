// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package test

import (
	"path/filepath"
	"slices"
	"testing"

	"github.com/hashicorp/hcl/v2"
	"github.com/hashicorp/hcl/v2/hclparse"
	"github.com/hashicorp/hcl/v2/hclsyntax"
	"github.com/stretchr/testify/require"
	"github.com/zclconf/go-cty/cty"
	"github.com/zclconf/go-cty/cty/function"
	"github.com/zclconf/go-cty/cty/function/stdlib"
)

// TestVPCDeletionPolicySource checks input validation and forwarding without
// invoking Terraform or creating cloud resources.
func TestVPCDeletionPolicySource(t *testing.T) {
	for _, moduleDir := range []string{".", "modules/vpc"} {
		t.Run(moduleDir, func(t *testing.T) {
			path := filepath.Join("..", "..", moduleDir)
			variables := vpcDeletionPolicyBody(t, filepath.Join(path, "variables.tf"))
			policy := vpcDeletionPolicyBlock(t, variables, "variable", "deletion_policy")

			typeAttr := policy.Body.Attributes["type"]
			require.NotNil(t, typeAttr)
			typeTraversal, diags := hcl.AbsTraversalForExpr(typeAttr.Expr)
			require.False(t, diags.HasErrors(), diags.Error())
			require.Len(t, typeTraversal, 1)
			require.Equal(t, "string", typeTraversal.RootName())

			defaultAttr := policy.Body.Attributes["default"]
			require.NotNil(t, defaultAttr)
			defaultValue, diags := defaultAttr.Expr.Value(nil)
			require.False(t, diags.HasErrors(), diags.Error())
			require.True(t, defaultValue.IsNull(), "preserve the provider-level policy by default")

			validation := vpcDeletionPolicyBlock(t, policy.Body, "validation")
			condition := validation.Body.Attributes["condition"]
			require.NotNil(t, condition)
			for _, tc := range []struct {
				name  string
				value cty.Value
				valid bool
			}{
				{"null", cty.NullVal(cty.String), true},
				{"DELETE", cty.StringVal("DELETE"), true},
				{"PREVENT", cty.StringVal("PREVENT"), true},
				{"ABANDON", cty.StringVal("ABANDON"), true},
				{"invalid", cty.StringVal("INVALID"), false},
				{"lowercase", cty.StringVal("prevent"), false},
				{"empty", cty.StringVal(""), false},
			} {
				t.Run(tc.name, func(t *testing.T) {
					ctx := &hcl.EvalContext{
						Variables: map[string]cty.Value{
							"var": cty.ObjectVal(map[string]cty.Value{"deletion_policy": tc.value}),
						},
						Functions: map[string]function.Function{"contains": stdlib.ContainsFunc},
					}
					result, diags := condition.Expr.Value(ctx)
					require.False(t, diags.HasErrors(), diags.Error())
					require.True(t, result.RawEquals(cty.BoolVal(tc.valid)))
				})
			}

			main := vpcDeletionPolicyBody(t, filepath.Join(path, "main.tf"))
			var target *hclsyntax.Block
			if moduleDir == "." {
				target = vpcDeletionPolicyBlock(t, main, "module", "vpc")
			} else {
				target = vpcDeletionPolicyBlock(t, main, "resource", "google_compute_network", "network")
			}
			argument := target.Body.Attributes["deletion_policy"]
			require.NotNil(t, argument)
			traversal, diags := hcl.AbsTraversalForExpr(argument.Expr)
			require.False(t, diags.HasErrors(), diags.Error())
			require.Len(t, traversal, 2)
			require.Equal(t, "var", traversal.RootName())
			require.IsType(t, hcl.TraverseAttr{}, traversal[1])
			require.Equal(t, "deletion_policy", traversal[1].(hcl.TraverseAttr).Name)
		})
	}
}

func vpcDeletionPolicyBody(t *testing.T, path string) *hclsyntax.Body {
	t.Helper()
	file, diags := hclparse.NewParser().ParseHCLFile(path)
	require.False(t, diags.HasErrors(), diags.Error())
	body, ok := file.Body.(*hclsyntax.Body)
	require.True(t, ok)
	return body
}

func vpcDeletionPolicyBlock(t *testing.T, body *hclsyntax.Body, blockType string, labels ...string) *hclsyntax.Block {
	t.Helper()
	for _, block := range body.Blocks {
		if block.Type == blockType && slices.Equal(block.Labels, labels) {
			return block
		}
	}
	t.Fatalf("missing %s block with labels %v", blockType, labels)
	return nil
}
