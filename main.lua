local composer = require('composer')

local options = {params = {  }}

local path = system.pathForFile( "history.txt", system.CachesDirectory )

-- file = io.open(path, "w")
-- if file then
--   file:write('0 0 0 0')
--   io.close( file )
-- end

local file = io.open( path, "r" )
print(path)

if file then
  io.close( file )
else
  file = io.open(path, "w")
  if file then
    file:write('0 0 0 0')
    io.close( file )
  end
end

composer.gotoScene('menu')
