Attribute VB_Name = "ListItem1_Revenue"
Option Explicit

Private Const REVENUE_GROWTH_MIN = 0.1  'revenue must grow by 10% each year

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

    Range("A2").Font.Bold = True
    Range("A2") = "Are sales increasing?"
    
    'name Revenue cell
    Range("B3").Name = "Revenue"
    
    'write "Revenue" text
    Range("Revenue").HorizontalAlignment = xlLeft
    Range("Revenue") = "Revenue"
    
    'populate revenue information
    Range("Revenue").Offset(0, 1) = dblRevenue(0)
    Range("Revenue").Offset(0, 2) = dblRevenue(1)
    Range("Revenue").Offset(0, 3) = dblRevenue(2)
    Range("Revenue").Offset(0, 4) = dblRevenue(3)
    Range("Revenue").Offset(0, 5) = dblRevenue(4)
    
    'revenue notes
    Range("Revenue").AddComment
    Range("Revenue").Comment.Visible = False
    Range("Revenue").Comment.Text Text:="Revenue is the income generated by a company from its business activities." & Chr(10) & _
                "Also known as the company's top line, it is the main reason a company goes into business." & Chr(10) & _
                "Without revenue, the company has nothing.  Fundamentally, stock growth starts with a company making money." & Chr(10) & _
                "The revenue should be increasing by 10% for the three most recent years."
    Range("Revenue").Comment.Shape.TextFrame.AutoSize = True
    
    CalculateRevenueYOYGrowth

End Sub

'===============================================================
' Procedure:    CalculateRevenueYOYGrowth
'
' Description:  Call procedure to calculate YOY growth for
'               revenue data. Format cells and display YOY growth.
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

    Dim dblYOYGrowth(0 To 4) As Double
    
    'name YOY cell
    Range("B4").Name = "YOYGrowth"
    Range("4:4").Name = "YOYRow"
    
    'write "YOY Growth" text
    Range("YOYGrowth").HorizontalAlignment = xlRight
    Range("YOYGrowth") = "YOY Growth (%)"
    
    Range("YOYRow").Font.Italic = True
    Range("YOYRow").NumberFormat = "0.0%"

    'populate YOY growth information
    '(0) is most recent year
    dblYOYGrowth(0) = CalculateYOYGrowth(dblRevenue(0), dblRevenue(1))
    dblYOYGrowth(1) = CalculateYOYGrowth(dblRevenue(1), dblRevenue(2))
    dblYOYGrowth(2) = CalculateYOYGrowth(dblRevenue(2), dblRevenue(3))
    dblYOYGrowth(3) = CalculateYOYGrowth(dblRevenue(3), dblRevenue(4))
    
    Call EvaluateRevenueYOYGrowth(Range("YOYGrowth"), dblYOYGrowth(0), dblYOYGrowth(1), dblYOYGrowth(2), dblYOYGrowth(3))
    
    Range("YOYGrowth").Offset(0, 5).HorizontalAlignment = xlCenter
    Range("YOYGrowth").Offset(0, 5) = "---"
    
End Sub

'===============================================================
' Procedure:    EvaluateRevenueYOYGrowth
'
' Description:  Display YOY growth information.
'               if revenue decreases -> red font
'               if revenue growth is < REVENUE_GROWTH_MIN -> orange font
'               else if revenue growth >= REVENUE_GROWTH_MIN -> green font
'
' Author:       Janice Laset Parkerson
'
' Notes:        N/A
'
' Parameters:   YOYGrowth As Range -> first cell of revenue YOY growth
'               YOY1, YOY2, YOY3, YOY4 -> YOY growth values
'                                         (YOY1 is most recent year)
'
' Returns:      N/A
'
' Rev History:  16Sept14 by Janice Laset Parkerson
'               - Initial Version
'===============================================================
Function EvaluateRevenueYOYGrowth(YOYGrowth As Range, YOY1, YOY2, YOY3, YOY4)
    
    YOYGrowth.Offset(0, 4).Select
    If YOY4 < 0 Then                                    'if revenue decreases
        Selection.Font.ColorIndex = FONT_COLOR_RED
    ElseIf YOY4 < REVENUE_GROWTH_MIN Then               'if revenue growth is less than required
        Selection.Font.ColorIndex = FONT_COLOR_ORANGE
    Else
        Selection.Font.ColorIndex = FONT_COLOR_GREEN    'if revenue growth is greater than required
    End If
    YOYGrowth.Offset(0, 4) = YOY4
    
    YOYGrowth.Offset(0, 3).Select
    If YOY3 < 0 Then
        Selection.Font.ColorIndex = FONT_COLOR_RED
    ElseIf YOY3 < REVENUE_GROWTH_MIN Then
        Selection.Font.ColorIndex = FONT_COLOR_ORANGE
    Else
        Selection.Font.ColorIndex = FONT_COLOR_GREEN
    End If
    YOYGrowth.Offset(0, 3) = YOY3
    
    YOYGrowth.Offset(0, 2).Select
    If YOY2 < 0 Then
        Selection.Font.ColorIndex = FONT_COLOR_RED
    ElseIf YOY2 < REVENUE_GROWTH_MIN Then
        Selection.Font.ColorIndex = FONT_COLOR_ORANGE
    Else
        Selection.Font.ColorIndex = FONT_COLOR_GREEN
    End If
    YOYGrowth.Offset(0, 2) = YOY2
    
    YOYGrowth.Offset(0, 1).Select
    If YOY1 < 0 Then
        Selection.Font.ColorIndex = FONT_COLOR_RED
    ElseIf YOY1 < REVENUE_GROWTH_MIN Then
        Selection.Font.ColorIndex = FONT_COLOR_ORANGE
    Else
        Selection.Font.ColorIndex = FONT_COLOR_GREEN
    End If
    YOYGrowth.Offset(0, 1) = YOY1
    
End Function

