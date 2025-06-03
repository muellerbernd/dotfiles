return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()

      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: toggle [b]reakpoint' })
      vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'DAP: run to [c]ursor' })

      -- Eval var under cursor
      vim.keymap.set('n', '<leader>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F13>', dap.restart)

      vim.keymap.set('n', '<leader>do', ui.open, { desc = 'DAP: Open UI' })
      vim.keymap.set('n', '<leader>dc', ui.close, { desc = 'DAP: Close UI' })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
      }

      dap.configurations.c = {
        {
          name = 'Launch',
          type = 'gdb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = 'Select and attach to process',
          type = 'gdb',
          request = 'attach',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          pid = function()
            local name = vim.fn.input 'Executable name (filter): '
            return require('dap.utils').pick_process { filter = name }
          end,
          cwd = '${workspaceFolder}',
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'gdb',
          request = 'attach',
          target = 'localhost:1234',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
        },
      }

      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

      -- dap.adapters.lldb = {
      --   type = 'executable',
      --   command = 'lldb', -- adjust as needed, must be absolute path
      --   name = 'lldb',
      -- }
      --
      -- dap.configurations.cpp = {
      --   {
      --     name = 'Launch',
      --     type = 'lldb',
      --     request = 'launch',
      --     program = function()
      --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      --     end,
      --     cwd = '${workspaceFolder}',
      --     stopOnEntry = false,
      --     args = {},
      --
      --     -- 💀
      --     -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
      --     --
      --     --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --     --
      --     -- Otherwise you might get the following error:
      --     --
      --     --    Error on launch: Failed to attach to the target process
      --     --
      --     -- But you should be aware of the implications:
      --     -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      --     -- runInTerminal = false,
      --   },
      -- }
      -- dap.configurations.c = dap.configurations.cpp
      -- dap.configurations.rust = dap.configurations.cpp
    end,
  },
}
