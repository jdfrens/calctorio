%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "test/", "web/", "apps/"],
        excluded: [~r"/_build/", ~r"/deps/"]
      },
      strict: true,
      color: true,
      checks: [
        #
        ## Consistency Checks
        #
        {Credo.Check.Consistency.ExceptionNames},
        {Credo.Check.Consistency.LineEndings},
        {Credo.Check.Consistency.ParameterPatternMatching},
        {Credo.Check.Consistency.SpaceAroundOperators},
        {Credo.Check.Consistency.SpaceInParentheses},
        {Credo.Check.Consistency.TabsOrSpaces},

        #
        ## Design Checks
        #
        {Credo.Check.Design.AliasUsage, priority: :low},
        {Credo.Check.Design.DuplicatedCode, excluded_macros: []},
        {Credo.Check.Design.TagTODO, exit_status: 2},
        {Credo.Check.Design.TagFIXME},

        #
        ## Readability Checks
        #
        {Credo.Check.Readability.AliasOrder},
        {Credo.Check.Readability.FunctionNames},
        {Credo.Check.Readability.LargeNumbers},
        {Credo.Check.Readability.MaxLineLength, priority: :low, max_length: 120},
        {Credo.Check.Readability.ModuleAttributeNames},
        {Credo.Check.Readability.ModuleDoc},
        {Credo.Check.Readability.ModuleNames},
        {Credo.Check.Readability.ParenthesesOnZeroArityDefs},
        {Credo.Check.Readability.ParenthesesInCondition},
        {Credo.Check.Readability.PredicateFunctionNames},
        {Credo.Check.Readability.PreferImplicitTry},
        {Credo.Check.Readability.RedundantBlankLines},
        {Credo.Check.Readability.StringSigils},
        {Credo.Check.Readability.TrailingBlankLine},
        {Credo.Check.Readability.TrailingWhiteSpace},
        {Credo.Check.Readability.VariableNames},
        {Credo.Check.Readability.Semicolons},
        {Credo.Check.Readability.SpaceAfterCommas},

        #
        ## Refactoring Opportunities
        #
        {Credo.Check.Refactor.DoubleBooleanNegation},
        {Credo.Check.Refactor.CondStatements},
        {Credo.Check.Refactor.CyclomaticComplexity},
        {Credo.Check.Refactor.FunctionArity},
        {Credo.Check.Refactor.LongQuoteBlocks},
        {Credo.Check.Refactor.MatchInCondition},
        {Credo.Check.Refactor.NegatedConditionsInUnless},
        {Credo.Check.Refactor.NegatedConditionsWithElse},
        {Credo.Check.Refactor.Nesting},
        {Credo.Check.Refactor.PipeChainStart,
         excluded_argument_types: [:atom, :binary, :fn, :keyword], excluded_functions: []},
        {Credo.Check.Refactor.UnlessWithElse},

        #
        ## Warnings
        #
        {Credo.Check.Warning.BoolOperationOnSameValues},
        {Credo.Check.Warning.ExpensiveEmptyEnumCheck},
        {Credo.Check.Warning.IExPry},
        {Credo.Check.Warning.IoInspect},
        {Credo.Check.Warning.LazyLogging},
        {Credo.Check.Warning.OperationOnSameValues},
        {Credo.Check.Warning.OperationWithConstantResult},
        {Credo.Check.Warning.UnusedEnumOperation},
        {Credo.Check.Warning.UnusedFileOperation},
        {Credo.Check.Warning.UnusedKeywordOperation},
        {Credo.Check.Warning.UnusedListOperation},
        {Credo.Check.Warning.UnusedPathOperation},
        {Credo.Check.Warning.UnusedRegexOperation},
        {Credo.Check.Warning.UnusedStringOperation},
        {Credo.Check.Warning.UnusedTupleOperation},
        {Credo.Check.Warning.RaiseInsideRescue},

        #
        # Controversial and experimental checks
        #
        {Credo.Check.Refactor.ABCSize},
        {Credo.Check.Refactor.AppendSingleItem},
        {Credo.Check.Refactor.VariableRebinding},
        {Credo.Check.Warning.MapGetUnsafePass},
        {Credo.Check.Consistency.MultiAliasImportRequireUse}
      ]
    }
  ]
}
