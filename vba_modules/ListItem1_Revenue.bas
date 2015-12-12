Attribute VB_Name = "ListItem1_Revenue"
Option Explicit

Private Const REVENUE_GROWTH_MIN = 0.1  'revenue must grow by 10% each year
Private ResultRevenue As Result
Private Const REVENUE_SCORE_MAX = 4
Private Const REVENUE_SCORE_WEIGHT = 25
Private ScoreRevenue As Integer
    
'===============================================================
' Procedure:    EvaluateRevenue
'
' Description:  Display revenue information.
'               Call procedure to display YOY growth information
'
' Author:       Janice Laset Parkerson
'
' Notes:        N/A
'
' Parameters:   N/A
'
' Returns:      N/A
'
' Rev History:  16Sept14 by Janice Laset Parkerson
'               - Initial Version
'===============================================================
Sub EvaluateRevenue()

    Dim i As Integer
    
    'populate revenue information
    For i = 0 To (iYearsAvailableIncome - 1)
        Range("Revenue").Offset(0, i + 1) = dblRevenue(i)
    Next i
    
    DisplayRevenueInfo
    
    CalculateRevenueYOYGrowth

End Sub

'===============================================================
' Procedure:    DisplayRevenueInfo
'
' Description:  Comment box information for revenue
'               - revenue requirements
'               - revenue information
'
' Author:       Janice Laset Parkerson
'
' Notes:        N/A
'
' Parameters:   N/A
'
' Returns:      N/A
'
' Rev History:  10Oct14 by Janice Laset Parkerson
'               - Initial Version
'===============================================================
Sub DisplayRevenueInfo()

    Range("ListItemRevenue") = "Are sales increasing?"
    Range("Revenue") = "Revenue"
    
    'revenue notes
    With Range("ListItemRevenue")
        .AddComment
        .Comment.Visible = False
        .Comment.Text Text:="What is it:" & Chr(10) & _
                "   Sales or Revenue is the income generated by a company from its business activities." & Chr(10) & _
                "Why is it important:" & Chr(10) & _
                "   Known as the company's top line, it is the main reason a company goes into business." & Chr(10) & _
                "   Stock growth starts with a company making money." & Chr(10) & _
                "What to look for:" & Chr(10) & _
                "   Revenue should increase by at least 10% every year." & Chr(10) & _
                "What to watch for:" & Chr(10) & _
                "   If net income is increasing significantly faster than revenue, it could mean the" & Chr(10) & _
                "   company is cutting costs. This may not be sustainable in the long term."
        .Comment.Shape.TextFrame.AutoSize = True
    End With

End Sub
'===============================================================
' Procedure:    CalculateRevenueYOYGrowth
'
' Description:  Call procedure to calculate and display YOY
'               growth for revenue data.
'
' Author:       Janice Laset Parkerson
'
' Notes:        N/A
'
' Parameters:   N/A
'
' Returns:      N/A
'
' Rev History:  16Sept14 by Janice Laset Parkerson
'               - Initial Version
'===============================================================
Sub CalculateRevenueYOYGrowth()

    Dim dblYOYGrowth(0 To 3) As Double
    Dim i As Integer
    
    Range("RevenueYOYGrowth") = "YOY Growth (%)"

    'populate YOY growth information
    '(0) is most recent year
    For i = 0 To (iYearsAvailableIncome - 2)
        dblYOYGrowth(i) = CalculateYOYGrowth(dblRevenue(i), dblRevenue(i + 1))
    Next i
    
    Call EvaluateRevenueYOYGrowth(Range("RevenueYOYGrowth"), dblYOYGrowth)
    
End Sub

'===============================================================
' Procedure:    EvaluateRevenueYOYGrowth
'
' Description:  Display YOY growth information.
'               if revenue growth is < REVENUE_GROWTH_MIN -> fail
'               else if revenue growth >= REVENUE_GROWTH_MIN -> pass
'
' Author:       Janice Laset Parkerson
'
' Notes:        N/A
'
' Parameters:   YOYGrowth As Range -> first cell of revenue YOY growth
'               YOY array -> YOY growth values
'                            YOY(0) is most recent year
'
' Returns:      N/A
'
' Rev History:  16Sept14 by Janice Laset Parkerson
'               - Initial Version
'
'               10Dec15 by Janice Laset Parkerson
'               - add scoring
'===============================================================
Function EvaluateRevenueYOYGrowth(YOYGrowth As Range, YOY() As Double)
    
    Dim i As Integer
    
    'initialize to PASS
    ResultRevenue = PASS
    
    ScoreRevenue = 0
    
    For i = 0 To (iYearsAvailableIncome - 2)
        YOYGrowth.Offset(0, i + 1).Select
        If YOY(i) < REVENUE_GROWTH_MIN Then                 'if revenue growth is less than required
            Selection.Font.ColorIndex = FONT_COLOR_RED
            ResultRevenue = FAIL
        Else
            Selection.Font.ColorIndex = FONT_COLOR_GREEN    'if revenue growth is greater than required
            ScoreRevenue = ScoreRevenue + (REVENUE_SCORE_MAX - i)
        End If
        YOYGrowth.Offset(0, i + 1) = YOY(i)
    Next i
        
    ScoreRevenue = ScoreRevenue * REVENUE_SCORE_WEIGHT

    CheckRevenuePassFail
    RevenueScore
    
End Function

'===============================================================
' Procedure:    CheckRevenuePassFail
'
' Description:  Display check or x mark if the revenue
'               passes or fails the criteria
'
' Author:       Janice Laset Parkerson
'
' Notes:        N/A
'
' Parameters:   N/A
'
' Returns:      N/A
'
' Rev History:  27Sept14 by Janice Laset Parkerson
'               - Initial Version
'===============================================================
Sub CheckRevenuePassFail()

    If ResultRevenue = PASS Then
        Range("RevenueCheck") = CHECK_MARK
        Range("RevenueCheck").Font.ColorIndex = FONT_COLOR_GREEN
    Else
        Range("RevenueCheck") = X_MARK
        Range("RevenueCheck").Font.ColorIndex = FONT_COLOR_RED
    End If

End Sub

'===============================================================
' Procedure:    RevenueScore
'
' Description:  Calculate score for revenue
'
' Author:       Janice Laset Parkerson
'
' Notes:        N/A
'
' Parameters:   N/A
'
' Returns:      N/A
'
' Rev History:  10Dec15 by Janice Laset Parkerson
'               - Initial Version
'===============================================================
Sub RevenueScore()

    Range("RevenueScore") = ScoreRevenue

End Sub
