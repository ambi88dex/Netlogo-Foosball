globals [iterator yval start? bxcor bycor y1 y2 y3 dir ygoalr ygoall ]
breed [balls ball]
breed [goalls goall]
breed [goalrs goalr]
breed [p1s p1]
breed [p2s p2]
breed [bar1s bar1]
breed [bar2s bar2]
breed [covers cover]
to setup
  clear-all
  ;reset-ticks
  set start? true
  ; create ball
  create-balls 1[
    set shape "ball tennis"
    set size 1.3
    ;setxy -13.5 0
    ask balls [
      set color red
      set heading 30 - random(60)
      setxy ( 5 - random(10) ) ( 5 - random(10) )
    ]
  ]

  ; create goal 1
    create-goalrs 1[
      set shape "goalrhs"
      set size 4
      set heading 180
      setxy 14 0

      ask goalr 1[
        set color pink
      ]
    ]
    ; create goal 2
    create-goalls 1[
      set shape "goallhs"
      set size 4
      set heading 0
      setxy -14 0

      ask goall 2 [
        set color cyan
      ]
    ]
    ; bar1
    create-bar1s 2[
      set shape "line"
      set color cyan
      set size 20
      set heading 0
      setxy -8 0
    ]
    ;bar2
    create-bar2s 2[
      set shape "line"
      set color pink
      set size 20
      set heading 0
      setxy 8 0
    ]
    ; p1 players
      set iterator 1
      repeat 3[
        create-p1s 1[
          set shape "person"
          set color cyan
          set size 2
          setxy -8 (-16 + 8 * iterator)
          set heading 0
          set iterator iterator + 1
        ]
      ]

      ;p2 players
      set iterator 1
      repeat 3[
        create-p2s 1[
          set shape "person"
          set color pink
          set size 2
          setxy 8 (-16 + 8 * iterator)
          set heading 0
          set iterator iterator + 1
        ]
      ]
      ; boundaries
      create-covers 1[
        set shape "line"
        set heading 0
        set size 30
        set color brown
        setxy -14 0
      ]
      create-covers 1[
        set shape "line"
        set heading 0
        set size 30
        set color brown
        setxy 14 0
      ]
      create-covers 1[
        set shape "line"
        set heading 90
        set size 28
        set color brown
        setxy 0 15
      ]
      create-covers 1[
        set shape "line"
        set heading 90
        set size 28
        set color brown
        setxy 0 -15
      ]


end

to p1up
  ask bar1s [fd 0.5]
  ask p1s [fd 0.5]
end

to p1down
  ask bar1s [fd -0.5]
  ask p1s [fd -0.5]
end

to p2up
  ask bar2s [fd 0.5]
  ask p2s [fd 0.5]
end

to p2down
  ask bar2s [fd -0.5]
  ask p2s [fd -0.5]
end

 ;set start? true
to simulate
  ;tick
  ask ball 0[
    set bxcor xcor
    set bycor ycor
    ;ifelse(xval < 7.4 and xval > -7.4 and start? = true )[
      ;set heading heading - 45 + random(90)
     ; fd 1
    ;]
    ;[
    ;]

    fd 0.15

  ]
  ask goall 2[

   set ygoall ycor
   if ((ygoall > 12.2) or (ygoall < -12.2))[
     set heading 180 - heading
   ]
   fd 0.1
  ]
  ask goalr 1[
   set ygoalr ycor
   if ((ygoall > 12.2) or (ygoall < -12.2))[
     set heading 180 - heading
   ]
   fd 0.1
  ]
  if(bxcor > 14)[
    ifelse (bycor > ( ygoalr - 1.8) and bycor < ( ygoalr + 1.8))[
      user-message "Player 1 wins"
      stop
    ]
    [
         ask ball 0[
           if(heading < 180)[
             set heading (360 - heading)
           ]

         ]

    ]

  ]
  if(bxcor < -14)[
    ifelse (bycor >(ygoall - 1.8 ) and bycor < (ygoall + 1.8))[
      user-message "Player 2 wins"
      stop
    ]
    [
         ask ball 0[
           if(heading > 180)[
             set heading (360 - heading)
           ]

         ]

    ]
  ]
  if(bycor > 15)[
      ask ball 0[
        ifelse (heading < 90 )[
        set heading (180 - heading)
        ]
        [
           if ( heading > 270 )[
             set heading (540 - heading)
           ]
        ]
    ]
  ]
  if(bycor < -15)[
    ask ball 0[

      ifelse (heading > 90 and heading < 180 )[
        set heading (180 - heading)
        ]
      [
        if (heading > 180 and heading < 270)[
          set heading (540 - heading )
        ]
      ]
    ]
  ]
  if ((bxcor > 7.8) and (bxcor < 8))[
    ask p2 12[
      set y1 ycor
    ]
    ask p2 11[
      set y2 ycor
    ]
    ask p2 10[
      set y3 ycor
    ]
    ask ball 0[
      set dir heading
    ]
    if (((( bycor - y1 > -1 ) and( bycor - y1 < 1)) or (( bycor - y2 > -1 ) and( bycor - y2 < 1)) or(( bycor - y3 > -1 ) and( bycor - y3 < 1)) ) and (dir > 0 and dir < 180))[
      ask ball 0[
        set heading ( 360 - heading )
    ]
    ]
  ]
  if ((bxcor > 8) and (bxcor < 8.2))[
    ask p2 12[
      set y1 ycor
    ]
    ask p2 11[
      set y2 ycor
    ]
    ask p2 10[
      set y3 ycor
    ]
    ask ball 0[
      set dir heading
    ]
    if (((( bycor - y1 > -1 ) and( bycor - y1 < 1)) or (( bycor - y2 > -1 ) and( bycor - y2 < 1)) or(( bycor - y3 > -1 ) and( bycor - y3 < 1)) ) and (dir > 180 and dir < 360))[
      ask ball 0[
        set heading ( 360 - heading )
    ]
    ]
  ]
  if ((bxcor < -7.8) and ( bxcor > -8 ))[
    ask p1 9[
      set y1 ycor
    ]
    ask p1 8[
      set y2 ycor
    ]
    ask p1 7[
      set y3 ycor
    ]
    ask ball 0[
      set dir heading
    ]
    if (((( bycor - y1 > -1 ) and( bycor - y1 < 1)) or (( bycor - y2 > -1 ) and( bycor - y2 < 1)) or(( bycor - y3 > -1 ) and( bycor - y3 < 1))) and (dir > 180 and dir < 360))[
      ask ball 0[
        set heading ( 360 - heading )
    ]
    ]
  ]
  if ((bxcor < -8) and ( bxcor > -8.2 ))[
    ask p1 9[
      set y1 ycor
    ]
    ask p1 8[
      set y2 ycor
    ]
    ask p1 7[
      set y3 ycor
    ]
    ask ball 0[
      set dir heading
    ]
    if (((( bycor - y1 > -1 ) and( bycor - y1 < 1)) or (( bycor - y2 > -1 ) and( bycor - y2 < 1)) or(( bycor - y3 > -1 ) and( bycor - y3 < 1))) and (dir > 0 and dir < 180))[
      ask ball 0[
        set heading ( 360 - heading )
    ]
    ]
  ]
  ask p1 8[
    set yval ycor
    ]
end
