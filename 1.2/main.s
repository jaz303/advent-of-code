

.global _start

.text

_start:
            ldr r7, =ram

            @ zero the cache
            mov r0, #0
            mov r1, #(1024 * 1024)
zero:       subs r1, #1       
            strb r0, [r7, r1]
            bne zero

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

            b movetest

move:       cmp r0, #0
            addeq r4, #1
            cmp r0, #1
            addeq r3, #1
            cmp r0, #2
            subeq r4, #1
            cmp r0, #3
            subeq r3, #1

            @ calculate cache offset
            @ assuming maximum bounds of 1024x1024
            add r9, r3, #512
            lsl r9, r9, #10
            add r9, r9, r4
            add r9, r9, #512

            @ check cache
            ldrb r10, [r7, r9]
            cmp r10, #0
            moveq r10, #1
            streqb r10, [r7, r9]
            bne break          

            subs r6, #1
movetest:   cmp r6, #0
            bne move

            subs r2, r2, #1
test:       bne loop

break:

            cmp r3, #0
            rsblt r3, r3, #0
            cmp r4, #0
            rsblt r4, r4, #0
            add r5, r3, r4      

stop:       b stop
