local lex_setup = require('lexer')
local parse = require('parser')
local ast = require('lua-ast').New()
local generator = require('generator')
local reader = require('reader')

local function compile(reader, filename, options)
    local ls = lex_setup(reader, filename)
    local tree = parse(ast, ls)
    local util = require("util")
    print(util.dump(tree))
    local luacode = generator(tree, filename)
    return luacode
end

local function lang_loadstring(src, filename, options)
    reader.string_init(src)
    return compile(reader.string, filename, options)
end

local function lang_loadfile(filename, options)
    reader.file_init(filename)
    return compile(reader.file, filename, options)
end

return { string = lang_loadstring, file = lang_loadfile }
