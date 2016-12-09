.global _start

.text

_start:
            @ r0: current heading
            @ 0 = north
            @ 1 = east
            @ 2 = south
            @ 3 = west
            mov r0, #0

            @ r1: data pointer
            ldr r1, =data
            
            @ r2: remaining
            ldr r8, =count
            ldr r2, [r8]

            @ r3, r4: (x,y)
            mov r3, #0
            mov r4, #0

            cmp r2, #0
            b test

loop:       @ update heading
            ldr r6, [r1], #4
            cmp r6, #0
            addeq r0, r0, #1
            subne r0, r0, #1
            and r0, r0, #0x03

            @ apply movement
            ldr r6, [r1], #4
            cmp r0, #0
            addeq r4, r6
            cmp r0, #1
            addeq r3, r6
            cmp r0, #2
            subeq r4, r6
            cmp r0, #3
            subeq r3, r6

            subs r2, r2, #1
test:       bne loop

            cmp r3, #0
            rsblt r3, r3, #0
            cmp r4, #0
            rsblt r4, r4, #0
            add r5, r3, r4      

stop:       b stop
