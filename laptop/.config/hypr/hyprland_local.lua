-- monitor=desc:BOE 0x0BCA,preferred,0x0,1
-- monitor=desc:LG Display 0x06B3,preferred,0x0,1
-- monitor=desc:LG Electronics 27GL850 006NTTQD3057,2560x1440@120.00Hz,auto-center-up,1
-- monitor=desc:Dell Inc. DELL U3818DW 5KC0375R099L,3840x1600@59.99Hz,auto-center-up,1
-- monitor=,preferred,auto-center-up,1

hl.monitor({ output = "BOE 0x0BCA", mode = "preferred", position = "0x0", scale = "1" })
hl.monitor({ output = "LG Display 0x06B3", mode = "preferred", position = "0x0", scale = "1" })
hl.monitor({ output = "", mode = "preferred", position = "auto-center-up", scale = "1" })

-- function executed at the end of the config
return function ()
  hl.config({
    general = {
      gaps_workspaces = 32
    },
    decoration = {
      blur = {
        enabled = false,
      },
    },
  })
end