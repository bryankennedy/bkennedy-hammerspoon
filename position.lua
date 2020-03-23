-- Copyright (c) 2016 Miro Mannino
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this
-- software and associated documentation files (the "Software"), to deal in the Software
-- without restriction, including without limitation the rights to use, copy, modify, merge,
-- publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
-- to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies
-- or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.

hs.window.animationDuration = 0.01

local sizes = {2, 3, 3/2}
local fullScreenSizes = {1, 4/3, 2}

local GRID = {w = 24, h = 24}
hs.grid.setGrid(GRID.w .. 'x' .. GRID.h)
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

local pressed = {
  up = false,
  down = false,
  left = false,
  right = false
}

function nextStep(dim, offs, cb)
  if hs.window.focusedWindow() then
    local axis = dim == 'w' and 'x' or 'y'
    local oppDim = dim == 'w' and 'h' or 'w'
    local oppAxis = dim == 'w' and 'y' or 'x'
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()

    cell = hs.grid.get(win, screen)

    local nextSize = sizes[1]
    for i=1,#sizes do
      if cell[dim] == GRID[dim] / sizes[i] and
        (cell[axis] + (offs and cell[dim] or 0)) == (offs and GRID[dim] or 0)
        then
          nextSize = sizes[(i % #sizes) + 1]
        break
      end
    end

    cb(cell, nextSize)
    if cell[oppAxis] ~= 0 and cell[oppAxis] + cell[oppDim] ~= GRID[oppDim] then
      cell[oppDim] = GRID[oppDim]
      cell[oppAxis] = 0
    end

    hs.grid.set(win, cell, screen)
  end
end

function nextFullScreenStep()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        local nextSize = fullScreenSizes[1]
        for i=1,#fullScreenSizes do
            if cell.w == GRID.w / fullScreenSizes[i] and
                    cell.h == GRID.h / fullScreenSizes[i] and
                    cell.x == (GRID.w - GRID.w / fullScreenSizes[i]) / 2 and
                    cell.y == (GRID.h - GRID.h / fullScreenSizes[i]) / 2 then
                nextSize = fullScreenSizes[(i % #fullScreenSizes) + 1]
                break
            end
        end

        cell.w = GRID.w / nextSize
        cell.h = GRID.h / nextSize
        cell.x = (GRID.w - GRID.w / nextSize) / 2
        cell.y = (GRID.h - GRID.h / nextSize) / 2

        cell.w = 22
        cell.h = 22
        cell.x = 0
        cell.y = 0

        hs.grid.set(win, cell, screen)
    end
end

fullWidth = 24
fullHeight = 24
hMargin = 0.4
vMargin = 0.7

function full()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.w = fullWidth - .4
        cell.h = fullHeight - .5
        cell.x = .2
        cell.y = .25

        hs.grid.set(win, cell, screen)
    end
end

function top()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.w = fullWidth - ( hMargin * 2 )
        cell.h = (fullHeight - ( vMargin * 3 )) / 2
        cell.x = hMargin
        cell.y = vMargin

        hs.grid.set(win, cell, screen)
    end
end

function bottom()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.w = fullWidth - ( hMargin * 2 )
        cell.h = (fullHeight - ( vMargin * 3 )) / 2
        cell.x = hMargin
        cell.y = ( vMargin * 2 ) + cell.h

        hs.grid.set(win, cell, screen)
    end
end

function centerOnly()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.x = ( fullWidth - cell.w ) / 2
        cell.y = ( fullWidth - cell.h ) / 2

        hs.grid.set(win, cell, screen)

    end
end

function center()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.w = ( fullWidth / 7 ) * 3
        cell.h = ( fullHeight / 5 ) * 4
        cell.x = ( fullWidth - cell.w ) / 2
        cell.y = ( fullWidth - cell.h ) / 2

        hs.grid.set(win, cell, screen)

        local log = hs.logger.new('mymodule','debug')
        log.i(cell) -- will print "[mymodule] Initializing" to the console

    end
end

function centerWide()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.w = ( fullWidth / 9 ) * 6
        cell.h = ( fullHeight / 5 ) * 4
        cell.x = ( fullWidth - cell.w ) / 2
        cell.y = ( fullWidth - cell.h ) / 2

        hs.grid.set(win, cell, screen)

        local log = hs.logger.new('mymodule','debug')
        log.i(cell) -- will print "[mymodule] Initializing" to the console

    end
end

function left()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.w = ( fullWidth / 2 )
        cell.h = fullHeight
        cell.x = 0
        cell.y = 0

        hs.grid.set(win, cell, screen)
    end
end

function right()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)

        cell.w = ( fullWidth / 2 )
        cell.h = fullHeight
        cell.x = ( fullWidth / 2 )
        cell.y = 0

        hs.grid.set(win, cell, screen)
    end
end

function throwLeft()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        win:moveOneScreenWest();

        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)


        cell.w = fullWidth
        cell.h = fullHeight
        cell.x = 0
        cell.y = 0

        hs.grid.set(win, cell, screen)
    end
end

function throwRight()
    if hs.window.focusedWindow() then
        local win = hs.window.frontmostWindow()
        win:moveOneScreenEast();

        local id = win:id()
        local screen = win:screen()

        cell = hs.grid.get(win, screen)


        cell.w = fullWidth
        cell.h = fullHeight
        cell.x = 0
        cell.y = 0

        hs.grid.set(win, cell, screen)
    end
end

function fullDimension(dim)
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()
    cell = hs.grid.get(win, screen)

    if (dim == 'x') then
      cell = '0,0 ' .. GRID.w .. 'x' .. GRID.h
    else
      cell[dim] = GRID[dim]
      cell[dim == 'w' and 'x' or 'y'] = 0
    end

    hs.grid.set(win, cell, screen)
  end
end

hs.hotkey.bind(hyperalt, "1", function ()
    centerOnly()
end)

hs.hotkey.bind(hyperalt, "3", function ()
    center()
end)

hs.hotkey.bind(hyperalt, "4", function ()
    centerWide()
end)

hs.hotkey.bind(hyper, "4", function ()
    left()
end)

hs.hotkey.bind(hyper, "5", function ()
    full()
end)

hs.hotkey.bind(hyper, "6", function ()
    right()
end)

hs.hotkey.bind(hyper, "7", function ()
    top()
end)

hs.hotkey.bind(hyper, "9", function ()
    bottom()
end)

hs.hotkey.bind(mash, "left", function ()
    throwLeft()
end)

hs.hotkey.bind(mash, "right", function ()
    throwRight()
end)

-- Show dimensions
-- Dev function - Disabled
--hs.hotkey.bind(hyper, "i", function ()
--  local win = hs.window.frontmostWindow()
--  local id = win:id()
--  local screen = win:screen()
--  cell = hs.grid.get(win, screen)
--    another = hs.grid.get(win, screen)
--  hs.alert.show(another)
--end)
