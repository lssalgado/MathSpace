local controller = {}

local pathStats = system.pathForFile( "stats.txt", system.CachesDirectory )

function resetStats()
  print("RESETING STATS")
  local fileStats = io.open(pathStats, "w")
  if fileStats then
    fileStats:write('0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0')
    -- fileStats:write('1 2 5 3 2 1 2 5 3 2 1 2 5 3 2 4 3 2 3 2 1 3 2 4')
    io.close( fileStats )
    return "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
    -- return "1 2 5 3 2 1 2 5 3 2 1 2 5 3 2 4 3 2 3 2 1 3 2 4"
  end
end

controller.resetStats = resetStats

function resetAllStats()
  print("RESETING ALL STATS")
  local fileStats = io.open(pathStats, "w")
  if fileStats then
    fileStats:write('0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0')
    io.close( fileStats )
  end

  path = system.pathForFile( "history.txt", system.CachesDirectory )

  file, errorString = io.open(path, "w")
  if not file then
    print( "File error: " .. errorString )
  else
    print("RESETING ALL STATS")
    file:write('0 0 0 0') -- USAR PARA FUNCIONAR NORMALMENTE
    -- file:write('1 1 1 1') -- USAR PARA IR DIRETO PARA O MODO 1
    -- file:write('2 1 1 1 1 1') -- USAR PARA IR DIRETO PARA O MODO 2
    -- file:write('3 1 1') -- USAR PARA IR DIRETO PARA O MODO 3
    io.close( file )
  end
end

controller.resetAllStats = resetAllStats

function loadStats()
  local fileStats = io.open( pathStats, "r" )
  if fileStats then
    local stats = fileStats:read("*a")
    io.close( fileStats )
    return stats
  else
    local fileStats = io.open(pathStats, "w")
    if fileStats then
      fileStats:write('0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0')
      io.close( fileStats )
      return "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
    end
  end
end

controller.loadStats = loadStats

function parseStats()
  local statsData = {}
  stats = loadStats()
  for word in stats:gmatch("%w+") do
    table.insert(statsData, word)
    -- print('word = ' .. word)
  end
  for i=1,table.getn(statsData) do
    print(statsData[i])
  end
  return statsData
end

controller.parseStats = parseStats

function addStats(posicao)
  local statsData = parseStats()
  statsData[posicao] = tonumber( statsData[posicao] ) + 1
  print("Mudando de " .. (statsData[posicao] - 1) .. " para " .. statsData[posicao] )
  fileStats = io.open( pathStats, "w" )
  newStats = ""
  for i=1,table.getn(statsData) do
    newStats = newStats .. " " .. statsData[i]
  end
  fileStats:write(newStats)
  io.close( fileStats )
end

controller.addStats = addStats

return controller
