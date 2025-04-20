# Neovim Kickstart 2025 (Optimized)

This repo contains my custom Neovim config for 2025, built on the foundation of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). This setup is designed to enhance your Neovim experience with modern features and seamless integration.

## Recent Optimizations

### Performance Improvements

1. **Lazy Loading Implementation**
   - `bufferline.lua`: Now lazy loads with `event = "BufReadPost"`
   - `lualine.lua`: Now lazy loads with `event = "VimEnter"`
   - `treesitter.lua`: Loads on `BufReadPost` and `BufNewFile`
   - Added optional startup profiling (commented out in init.lua)

2. **Language-Specific Optimizations**
   - Treesitter: Separated core parsers (JS/TS/JSX/TSX/HTML/CSS/JSON/Lua) from extended parsers
   - LSP: Added priority levels to load web-focused LSPs first

3. **Plugin Organization**
   - Reorganized plugin loading order in init.lua for better clarity and logical grouping
   - Categorized plugins by function (UI, core, development, etc.)

### Feature Enhancements

1. **JS/TS Development**
   - Added import organization for JS/TS files through eslint_d
   - Prioritized web-focused LSPs for faster loading

2. **Configuration Structure**
   - Improved modularity for easier maintenance

## Usage Notes

1. **Performance Monitoring**:
   - Uncomment the profiling section in init.lua to track startup time

2. **Core Web Languages**:
   - JavaScript, TypeScript, JSX, TSX, HTML, CSS are prioritized

3. **Extended Language Support**:
   - Other languages are supported but optimized for lazy loading

4. **Tab Keybinding Note**:
   - Be aware of potential conflict between buffer navigation and completion

### Watch the Full Setup Guide

To get started and explore this config in detail, check out the video tutorial:

[![Full Neovim Setup from Scratch in 2025
](https://img.youtube.com/vi/KYDG3AHgYEs/0.jpg)](https://youtu.be/KYDG3AHgYEs?si=I71UjuoQg2fHLGyu)
