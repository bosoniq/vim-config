local ls = require("luasnip")

-- Config
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

-- functions
local function renderTypeHint(args)
    return string.gsub(args[1][1], "^%l", string.upper)
end

-- Snippet definition
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")



ls.add_snippets("php", {
    s("dd", fmt("dd(${});", { i(1, "test") })),
    s("shout", fmt("echo '{}!'; exit;", { i(1, "here") })),
    s({trig = "vd", name = "var dec"}, fmt("${} = {};", { i(1, "varName"), i(2, "value") })),
    s({trig = "pd", name = "prop dec"}, fmt("private {} ${} = {};", { i(1, "type"), i(2, "varName"), i(3, "value") })),

    -- doc snippets
    s("doc", fmt("/** {} */", { i(1, "value") })),
    s("docTodo", fmt("// TODO: {}", { i(1, "message") })),
    s("docNote", fmt("// NOTE: {}", { i(1, "message") })),
    s("docParam", fmt("@param {} {}", { i(1, "type"), i(1, "varName") })),
    s("docReturn", fmt("@return {}", { i(1, "type") })),
    s("docThrows", fmt("@throws {}", { i(1, "Exception") })),

    -- evaluation snippets
    s("eqstr", fmt("'' === ${}", { i(1, "var") })),
    s("eqnul", fmt("null === ${}", { i(1, "var") })),
    s("eqarr", fmt("[] === ${}", { i(1, "var") })),
    s("eqins", fmt("{} instanceof {}", { i(1, "variable"),  i(2, "class")})),

    -- php constructs
    s({trig = "th", name = "$this->"}, fmt("$this->{}", { i(1, "val") })),
    s({trig = "mc", desc = "$this->method(hint $param)"}, fmt("$this->{}({} ${});", { i(1, "method"), i(2, "hint"), i(3, "var") })),
    s(
        {trig = "foreach", desc = "foreach ($arr as $key => $value) {....}"},
        fmt(
            [[
                foreach (${} as ${} => ${}) {{
                    {}
                }}

            ]],
            {
                i(1, "array"),
                i(2, "key"),
                i(3, "value"),
                i(0),
            }
        )
    ),
    s(
        {trig = "while", desc = "while (condition) {....}"},
        fmt(
            [[
                while ({}) {{
                    {}
                }}

            ]],
            {
                i(1, "assertion"),
                i(0),
            }
        )
    ),
    s(
        {trig = "do", desc = "do {....} while (condition)"},
        fmt(
            [[
                do {{
                    {}
                }} while ({})
            ]],
            {
                i(0),
                i(1, "assertion"),
            }
        )
    ),
    s(
        {trig = "if", desc = "if(condition) {....}"},
        fmt(
            [[
                if ({}) {{
                    {}
                }}

            ]],
            {
                i(1, "condition"),
                i(0),
            }
        )
    ),
    s({trig = "m", name = "New method", desc = "Create a new class method"},
      fmt(
          [[
              public function {}(): {}
              {{
                  return{};
              }}
          ]],
          {
              i(1, "NewName"),
              i(2, "string"),
              i(3, " ''"),
          }
      )
    ),
    s({trig = "c", name = "New construct", desc = "Create a new class construct"},
        {
            t({ "", "public function __construct(private readonly " }),
            f(renderTypeHint, 1),
            t(" $"),
            i(1, "paramName"),
            t({ ")" }),
            t({ "", "{" }),
            t({ "", "}" }),
        }
    ),
    s({trig = "i", name = "New invoke", desc = "Create a new class invoke method"},
        fmt(
            [[
                public function __invoke({} ${})
                {{
                    {}
                }}
            ]],
            {
                i(1, "hint"),
                i(1, "param"),
                i(0),
            }
        )
    ),
    s({trig = "match", name = "New match", desc = "Create a new match"},
        fmt(
            [[
                ${} = match (${}) {{
                    'value' => {},
                    default => new Exception(),
                }};
            ]],
            {
                i(1, "result"),
                i(2, "subject_expression"),
                i(3, "result_expression"),
            }
        )
    ),
    s({trig = "array_map", name = "New array_map"},
        fmt(
            [[
                $result = array_map({}, ${});
            ]],
            {
                i(0, "fn($val) => $val"),
                i(1, "array"),
            }
        )
    ),
    s({trig = "array_filter", name = "New array_filter"},
        fmt(
            [[
                $result = array_filter(${}, {});
            ]],
            {
                i(1, "array"),
                i(0, "fn($val) => return $val"),
            }
        )
    ),

    -- unit test snippets
    s({trig = "tm", name = "New test method", desc = "Create a new unit test method"},
      fmt(
          [[
              /**
               * @Given
               * @When Call to
               * @Then
               */
              public function test{}(): void
              {{
                  // Given

                  // When
                  $result = $this->{}->{}(${});

                  // Then
                  self::assertTrue($result);
              }}
          ]],
          {
              i(1, "Name"),
              i(2, "Service"),
              i(3, "Method"),
              i(4, "Param"),
          }
      )
    ),
    s({trig = "ts", name = "New unit test setup", desc = "Create a new unit test setup method"},
        {
          t({ "", "private " }),
          f(renderTypeHint, 1),
          t("|MockObject $"),
          i(1, "className"),
          t(";"),
          t({ "", "" }),
          t({ "", "" }),
          t("protected function setUp(): void"),
          t({ "", "{" }),
          t({ "", "" }),
          t("\tparent::setUp();"),
          t({ "", "" }),
          t({ "", "" }),
          t("\t$this->"),
          rep(1),
          t(" = new "),
          f(renderTypeHint, 1),
          t("("),
          i(0),
          t(");"),
          t({ "", "}" }),
        }
    ),
    s({trig = "tmk", name = "New test class mock", desc = "Create a new unit test class mock"},
      fmt(
          [[
              $this->{} = $this->getMock({}::class);
          ]],
          {
              i(1, "name"),
              i(2, "Class"),
          }
      )
    ),
    s({trig = "tmkc", name = "New test mock class call", desc = "Create a new unit test mock class call"},
      fmt(
          [[
              $this->{}->expects(self::once())
              ->method('{}')
              ->with({})
              ->willReturn({});
          ]],
          {
              i(1, "mock"),
              i(2, "method"),
              i(3, "params"),
              i(4, "result"),
          }
      )
    ),
    s({trig = "tmkp", name = "New test class mock property", desc = "Create a new unit test class mock property"},
      fmt(
          [[
              private {}|MockObject ${};
          ]],
          {
              i(1, "Class"),
              i(2, "property"),
          }
      )
    ),
})
