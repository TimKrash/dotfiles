local colorscheme = "tokyonight-storm"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  print("Colorscheme " .. colorscheme .. " not found! Resorting to default\n")
  return
else
  if vim.fn.has('termguicolors') == 1 then
    vim.o.termguicolors = true
  end

  vim.g.sonokai_style = 'andromeda'
  vim.g.sonokai_better_performance = 1
end
