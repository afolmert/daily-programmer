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


ParseDieString(Str, ByRef Left, ByRef Right)
{
   FoundPos := InStr(Str, "d")
   Left := SubStr(Str, 1, FoundPos - 1)
   Right := SubStr(Str, FoundPos + 1)
}


RollDie(DieString)
{
    Left := 0
    Right := 0
    ParseDieString(DieString, Left, Right)

    Result := ""
    Loop, %Left%
    {
        Random, Roll, 1, %Right%
        if !Result
            Result := Roll
        else 
            Result .= " " . Roll

    }
    return Result
}


Main()
{
    Result := RollDie("4d8")
    Log("4d8: " + Result)

    Result := RollDie("7d8")
    Log("7d8: " + Result)

    Result := RollDie("1d10")
    Log("1d10: " + Result)
}




Main()


;; Testing functions 


TestRandom()
{
    Loop, 10
    {
        Num := 0
        Random, Num, 1, 10
        Log("New random number is : " + Num)
    }
}


TestParseRoll()
{
    Left := 0
    Right := 0

    ParseDieString("5d26", Left, Right)
    Log("Left is " + Left)
    Log("Right is " + Right)

    ParseDieString("7d23", Left, Right)
    Log("Left is " + Left)
    Log("Right is " + Right)

}
