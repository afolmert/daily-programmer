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

LookNSay(Input)
{
    if (strlen(Input) == 0)
    {
        return "1" . Input
    }

    Result := ""
    Count := 0
    Prev := ""

    Loop, Parse, Input
    {
        if (Prev == "")
        {
            Prev := A_LoopField
            Count++

        }
        else if (A_LoopField == Prev)
        {
            Count++
        }
        else
        {
            Result .= Count . Prev
            Prev := A_LoopField
            Count := 1
        }

    }
    ;; append remaining
    if Count > 0
    {
        Result .= Count . Prev

    }
    return Result
}


Main()
{
    Seed := "1"
    Loop, 10
    {
        Seed := LookNSay(Seed)
        Log(Seed)

    }
}



Main()
