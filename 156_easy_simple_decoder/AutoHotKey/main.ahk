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

Translate(Char)
{
    Return Chr(Ord(Char) - 4)
}

DecodeMessage(Message)
{
    Result := ""
    Loop, Parse, Message
    {
        Result .= Translate(A_LoopField)
    }
    Log(Result)
}



Main()
{
    FileRead, Message, input.txt
    DecodeMessage(Message)
}



Main()
