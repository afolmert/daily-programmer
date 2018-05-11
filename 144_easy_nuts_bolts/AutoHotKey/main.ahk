;
; Nuts and Bolts solution
;
;
; Useful functions
;

Log(msg)
{
    FileAppend,
    (
        [%A_NowUTC%]: %msg%`n
    ), Output.log
}


;
; Solution to the problem
;


Resolve(Input)
{
    Dict := {}
    Result := ""
    Loop, Parse, Input, `n, `r  ; Specifying `n prior to `r allows both Windows and Unix files to be parsed.
    {
;        Result .= "Line number " . A_Index . ": " . A_LoopField  . "`n"

        Items := StrSplit(A_LoopField, A_Space)
        Result .= " Item 0 " . Items[1] . " and item 1 " . Items[2] . "`n"
        Key := Items[1]
        Value := Items[2]

        Dict[Key] = Value

    }
    Log(Result)
}



Main()
{
    FileRead, Input, input.txt
    Resolve(Input)
}



Main()
