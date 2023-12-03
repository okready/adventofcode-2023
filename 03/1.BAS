DECLARE FUNCTION Min% (x%, y%)
DECLARE FUNCTION Max% (x%, y%)
DECLARE FUNCTION IsDigit% (c$)
DECLARE SUB FinishNumParse (curnum$)
DECLARE SUB FinishNumScan (numid%, xlo%, xhi%, y%)

CONST ENGINEWIDTH = 140
CONST ENGINEHEIGHT = 140

CONST MAXNUMBERS = 1500
CONST BLANKID = -1
CONST SYMBOLID = -2

DIM SHARED engine%(ENGINEWIDTH - 1, ENGINEHEIGHT - 1)
DIM SHARED nums%(MAXNUMBERS - 1)
DIM SHARED numcount%
DIM SHARED result&

y% = 0
OPEN "INPUT" FOR INPUT ACCESS READ AS #1
DO UNTIL (EOF(1))
    LINE INPUT #1, ln$
    FOR x% = 0 TO ENGINEWIDTH - 1
        c$ = MID$(ln$, x% + 1, 1)
        IF IsDigit%(c$) THEN
            curnum$ = curnum$ + c$
            engine%(x%, y%) = numcount%
        ELSE
            FinishNumParse curnum$
            IF c$ = "." THEN
                engine%(x%, y%) = BLANKID
            ELSE
                engine%(x%, y%) = SYMBOLID
            END IF
        END IF
    NEXT

    FinishNumParse curnum$
    y% = y% + 1
LOOP

numid% = -1
FOR y% = 0 TO ENGINEHEIGHT - 1
    FOR x% = 0 TO ENGINEWIDTH - 1
        id% = engine%(x%, y%)
        IF id% >= 0 THEN
            IF numid% < 0 THEN
                numid% = id%
                xlo% = x%
            END IF
        ELSE
            FinishNumScan numid%, xlo%, x% - 1, y%
        END IF
    NEXT

    FinishNumScan numid%, xlo%, ENGINEWIDTH - 1, y%
NEXT

PRINT result&

SUB FinishNumParse (curnum$)
    IF LEN(curnum$) <> 0 THEN
        nums%(numcount%) = VAL(curnum$)
        numcount% = numcount% + 1
        curnum$ = ""
    END IF
END SUB

SUB FinishNumScan (numid%, xlo%, xhi%, y%)
    IF numid% < 0 THEN
        EXIT SUB
    END IF

    xstart% = Max%(xlo% - 1, 0)
    xend% = Min%(xhi% + 1, ENGINEWIDTH - 1)
    ystart% = Max%(y% - 1, 0)
    yend% = Min%(y% + 1, ENGINEHEIGHT - 1)
    FOR ty% = ystart% TO yend%
        FOR tx% = xstart% TO xend%
            IF engine%(tx%, ty%) = SYMBOLID THEN
                result& = result& + nums%(numid%)
                numid% = -1
                EXIT SUB
            END IF
        NEXT
    NEXT

    numid% = -1
END SUB

FUNCTION IsDigit% (c$)
    CONST ASC0 = 48
    CONST ASC9 = 57

    casc% = ASC(c$)
    IsDigit% = casc% >= ASC0 AND casc% <= ASC9
END FUNCTION

FUNCTION Max% (x%, y%)
    IF x% >= y% THEN
        Max% = x%
    ELSE
        Max% = y%
    END IF
END FUNCTION

FUNCTION Min% (x%, y%)
    IF x% <= y% THEN
        Min% = x%
    ELSE
        Min% = y%
    END IF
END FUNCTION

