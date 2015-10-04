/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWidgets module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia. For licensing terms and
** conditions see http://qt.digia.com/licensing. For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights. These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QCALENDARWIDGET_H
#define QCALENDARWIDGET_H

public import qt.QtWidgets.qwidget;
public import qt.QtCore.qdatetime;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_CALENDARWIDGET

class QDate;
class QTextCharFormat;
class QCalendarWidgetPrivate;

class Q_WIDGETS_EXPORT QCalendarWidget : public QWidget
{
    mixin Q_OBJECT;
    Q_ENUMS(Qt.DayOfWeek)
    Q_ENUMS(HorizontalHeaderFormat)
    Q_ENUMS(VerticalHeaderFormat)
    Q_ENUMS(SelectionMode)
    mixin Q_PROPERTY!(QDate, "selectedDate", "READ", "selectedDate", "WRITE", "setSelectedDate");
    mixin Q_PROPERTY!(QDate, "minimumDate", "READ", "minimumDate", "WRITE", "setMinimumDate");
    mixin Q_PROPERTY!(QDate, "maximumDate", "READ", "maximumDate", "WRITE", "setMaximumDate");
    mixin Q_PROPERTY!(Qt.DayOfWeek, "firstDayOfWeek", "READ", "firstDayOfWeek", "WRITE", "setFirstDayOfWeek");
    mixin Q_PROPERTY!(bool, "gridVisible", "READ", "isGridVisible", "WRITE", "setGridVisible");
    mixin Q_PROPERTY!(SelectionMode, "selectionMode", "READ", "selectionMode", "WRITE", "setSelectionMode");
    mixin Q_PROPERTY!(HorizontalHeaderFormat, "horizontalHeaderFormat", "READ", "horizontalHeaderFormat", "WRITE", "setHorizontalHeaderFormat");
    mixin Q_PROPERTY!(VerticalHeaderFormat, "verticalHeaderFormat", "READ", "verticalHeaderFormat", "WRITE", "setVerticalHeaderFormat");
    mixin Q_PROPERTY!(bool, "navigationBarVisible", "READ", "isNavigationBarVisible", "WRITE", "setNavigationBarVisible");
    mixin Q_PROPERTY!(bool, "dateEditEnabled", "READ", "isDateEditEnabled", "WRITE", "setDateEditEnabled");
    mixin Q_PROPERTY!(int, "dateEditAcceptDelay", "READ", "dateEditAcceptDelay", "WRITE", "setDateEditAcceptDelay");

public:
    enum HorizontalHeaderFormat {
        NoHorizontalHeader,
        SingleLetterDayNames,
        ShortDayNames,
        LongDayNames
    };

    enum VerticalHeaderFormat {
        NoVerticalHeader,
        ISOWeekNumbers
    };

    enum SelectionMode {
        NoSelection,
        SingleSelection
    };

    explicit QCalendarWidget(QWidget *parent = 0);
    ~QCalendarWidget();

    /+virtual+/ QSize sizeHint() const;
    /+virtual+/ QSize minimumSizeHint() const;

    QDate selectedDate() const;

    int yearShown() const;
    int monthShown() const;

    QDate minimumDate() const;
    void setMinimumDate(ref const(QDate) date);

    QDate maximumDate() const;
    void setMaximumDate(ref const(QDate) date);

    Qt.DayOfWeek firstDayOfWeek() const;
    void setFirstDayOfWeek(Qt.DayOfWeek dayOfWeek);

    bool isNavigationBarVisible() const;
    bool isGridVisible() const;

    SelectionMode selectionMode() const;
    void setSelectionMode(SelectionMode mode);

    HorizontalHeaderFormat horizontalHeaderFormat() const;
    void setHorizontalHeaderFormat(HorizontalHeaderFormat format);

    VerticalHeaderFormat verticalHeaderFormat() const;
    void setVerticalHeaderFormat(VerticalHeaderFormat format);

    QTextCharFormat headerTextFormat() const;
    void setHeaderTextFormat(ref const(QTextCharFormat) format);

    QTextCharFormat weekdayTextFormat(Qt.DayOfWeek dayOfWeek) const;
    void setWeekdayTextFormat(Qt.DayOfWeek dayOfWeek, ref const(QTextCharFormat) format);

    QMap<QDate, QTextCharFormat> dateTextFormat() const;
    QTextCharFormat dateTextFormat(ref const(QDate) date) const;
    void setDateTextFormat(ref const(QDate) date, ref const(QTextCharFormat) format);

    bool isDateEditEnabled() const;
    void setDateEditEnabled(bool enable);

    int dateEditAcceptDelay() const;
    void setDateEditAcceptDelay(int delay);

protected:
    bool event(QEvent *event);
    bool eventFilter(QObject *watched, QEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void resizeEvent(QResizeEvent * event);
    void keyPressEvent(QKeyEvent * event);

    /+virtual+/ void paintCell(QPainter *painter, ref const(QRect) rect, ref const(QDate) date) const;
    void updateCell(ref const(QDate) date);
    void updateCells();

public Q_SLOTS:
    void setSelectedDate(ref const(QDate) date);
    void setDateRange(ref const(QDate) min, ref const(QDate) max);
    void setCurrentPage(int year, int month);
    void setGridVisible(bool show);
    void setNavigationBarVisible(bool visible);
    void showNextMonth();
    void showPreviousMonth();
    void showNextYear();
    void showPreviousYear();
    void showSelectedDate();
    void showToday();

Q_SIGNALS:
    void selectionChanged();
    void clicked(ref const(QDate) date);
    void activated(ref const(QDate) date);
    void currentPageChanged(int year, int month);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_slotShowDate(ref const(QDate) date))
    Q_PRIVATE_SLOT(d_func(), void _q_slotChangeDate(ref const(QDate) date))
    Q_PRIVATE_SLOT(d_func(), void _q_slotChangeDate(ref const(QDate) date, bool changeMonth))
    Q_PRIVATE_SLOT(d_func(), void _q_editingFinished())
    Q_PRIVATE_SLOT(d_func(), void _q_prevMonthClicked())
    Q_PRIVATE_SLOT(d_func(), void _q_nextMonthClicked())
    Q_PRIVATE_SLOT(d_func(), void _q_yearEditingFinished())
    Q_PRIVATE_SLOT(d_func(), void _q_yearClicked())
    Q_PRIVATE_SLOT(d_func(), void _q_monthChanged(QAction *act))

};

#endif // QT_NO_CALENDARWIDGET

QT_END_NAMESPACE

#endif // QCALENDARWIDGET_H

