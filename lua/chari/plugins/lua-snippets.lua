return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets', -- big community snippets pack
  },
  build = 'make install_jsregexp', -- for regex support in snippets
  config = function()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local fmt = require('luasnip.extras.fmt').fmt

    -- Load friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- Keymaps for snippet navigation
    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        return '<Tab>'
      end
    end, { expr = true, silent = true })

    vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        return '<S-Tab>'
      end
    end, { expr = true, silent = true })

    -- ========= Custom snippets =========
    ls.add_snippets('typescriptreact', {
      -- React Functional Component
      s(
        'rfc',
        fmt(
          [[
        const {}: React.FC = () => {{
          return (
            <>
              <h1>{}</h1>
            </>
          )
        }}

        export default {}
      ]],
          { i(1, 'Component'), i(2, 'test'), i(1) }
        )
      ),

      -- useState hook
      s(
        'us',
        fmt(
          [[
        const [{}, set{}] = useState({})
      ]],
          {
            i(1, 'state'),
            i(2, 'State'),
            i(3, 'null'),
          }
        )
      ),

      -- useEffect hook
      s(
        'ue',
        fmt(
          [[
        useEffect(() => {{
          {}
        }}, [{}])
      ]],
          { i(1, '// effect'), i(2) }
        )
      ),
    })
    ls.add_snippets('javascript', {
      s('fn', fmt('const {} = () => {{ {} }}', { i(1, 'myFunction'), i(2) })),
    })

    -- For TS
    ls.add_snippets('typescript', {
      s('fn', fmt('const {} = () => {{ {} }}', { i(1, 'myFunction'), i(2) })),
    })

    ls.add_snippets('all', {
      -- TODO comment
      s('todo', fmt('// TODO: {}', { i(1) })),
    })
  end,
}
