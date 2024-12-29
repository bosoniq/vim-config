local ls = require("luasnip")

-- Config
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})

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
    s("docTodo", fmt("// TODO: {}", { i(1, "message") })),
    s("docNote", fmt("// NOTE: {}", { i(1, "message") })),
    s("docParam", fmt("@param {} {}", { i(1, "type"), i(1, "varName") })),
    s("docReturn", fmt("@return {}", { i(1, "type") })),
    s("docThrows", fmt("@throws {}", { i(1, "Exception") })),

    -- comparison snippets
    s("eqstr", fmt("'' === ${}", { i(1, "var") })),
    s("eqnul", fmt("null === ${}", { i(1, "var") })),
    s("eqarr", fmt("[]=== ${}", { i(1, "var") })),

    -- php constructs
    s("foreach", fmt(
        [[
            foreach(${} as ${} => ${}) {{
                {}
            }}

        ]],
        {
            i(1, "array"),
            i(2, "key"),
            i(3, "value"),
            i(0),
        }
    )),
    s("if", fmt(
        [[
            if({}) {{
                {}
            }}

        ]],
        {
            i(1, "condition"),
            i(0),
        }
    )),
    s({trig = "mc", desc = "method call"}, fmt("$this->{}({} ${});", { i(1, "method"), i(2, "hint"), i(3, "var") })),
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
                }}
            ]],
            {
                i(1, "hint"),
                i(1, "param"),
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
    -- s("testset", fmt(
    --     [[
    --         private `!p snip.rv = uppercase_first(t[1])`|MockObject $${1};
    --
    --         protected function setUp(): void
    --         {{
    --             parent::setUp();
    --
    --             $this->{} = $this->getMock(`!p snip.rv = uppercase_first(t[1])`::class);
    --
    --             $this->{} = new `!p snip.rv = uppercase_first(t[2])`(
    --                 $this->{},
    --             );
    --         }}
    --     ]],
    --     {
    --         i(1, "Name"),
    --         i(2, "service"),
    --         i(3, "method"),
    --         i(4, "param"),
    --     }
    -- ))

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
