local clang = require 'clang'
local index = clang.Index()
local unsaved = {['x.c']='int fun;\nint main() {int v;return f;}'}
local unit = index:parse('x.c', {'-Wall'}, unsaved, {clang.TranslationUnit.PrecompiledPreamble})
unit:reparse(unsaved)
local cursor = unit.cursor
print('Root cursor:', cursor.kind.string, cursor.spelling)
cursor:visit(function(cursor)
    print('Visiting:', cursor.kind.string, cursor.spelling)
    local compl = cursor:get_completion_string()
    print('Priority:', compl.priority)
    print('Chunks:')
    for _, c in ipairs(compl.chunks) do
        print('Text:', c.text)
    end
    return cursor.visit_recurse -- or clang.Cursor.visit_recurse
end)
for i, v in ipairs(cursor:get_children()) do
    print('Child:', v.kind.string, v.spelling)
end
print()
local completion_results = unit:complete_at('x.c', 2, 26, unsaved)
for _, result in pairs(completion_results.results) do
    print('Completion result:', result.kind.string)
    print('Chunks:')
    for _, c in ipairs(result.string.chunks) do
        print('Text:', c.text)
        print('Kind:', c.kind.string)
    end
end
