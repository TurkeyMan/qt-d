/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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

#ifndef QTEXTTABLE_H
#define QTEXTTABLE_H

public import qt.QtCore.qglobal;
public import qt.QtCore.qobject;
public import qt.QtGui.qtextobject;

QT_BEGIN_NAMESPACE


class QTextCursor;
class QTextTable;
class QTextTablePrivate;

class Q_GUI_EXPORT QTextTableCell
{
public:
    QTextTableCell() : table(0) {}
    ~QTextTableCell() {}
    QTextTableCell(ref const(QTextTableCell) o) : table(o.table), fragment(o.fragment) {}
    QTextTableCell &operator=(ref const(QTextTableCell) o)
    { table = o.table; fragment = o.fragment; return *this; }

    void setFormat(ref const(QTextCharFormat) format);
    QTextCharFormat format() const;

    int row() const;
    int column() const;

    int rowSpan() const;
    int columnSpan() const;

    /+inline+/ bool isValid() const { return table != 0; }

    QTextCursor firstCursorPosition() const;
    QTextCursor lastCursorPosition() const;
    int firstPosition() const;
    int lastPosition() const;

    /+inline+/ bool operator==(ref const(QTextTableCell) other) const
    { return table == other.table && fragment == other.fragment; }
    /+inline+/ bool operator!=(ref const(QTextTableCell) other) const
    { return !operator==(other); }

    QTextFrame::iterator begin() const;
    QTextFrame::iterator end() const;

    int tableCellFormatIndex() const;

private:
    friend class QTextTable;
    QTextTableCell(const(QTextTable)* t, int f)
        : table(t), fragment(f) {}

    const(QTextTable)* table;
    int fragment;
};

class Q_GUI_EXPORT QTextTable : public QTextFrame
{
    mixin Q_OBJECT;
public:
    explicit QTextTable(QTextDocument *doc);
    ~QTextTable();

    void resize(int rows, int cols);
    void insertRows(int pos, int num);
    void insertColumns(int pos, int num);
    void appendRows(int count);
    void appendColumns(int count);
    void removeRows(int pos, int num);
    void removeColumns(int pos, int num);

    void mergeCells(int row, int col, int numRows, int numCols);
    void mergeCells(ref const(QTextCursor) cursor);
    void splitCell(int row, int col, int numRows, int numCols);

    int rows() const;
    int columns() const;

    QTextTableCell cellAt(int row, int col) const;
    QTextTableCell cellAt(int position) const;
    QTextTableCell cellAt(ref const(QTextCursor) c) const;

    QTextCursor rowStart(ref const(QTextCursor) c) const;
    QTextCursor rowEnd(ref const(QTextCursor) c) const;

    void setFormat(ref const(QTextTableFormat) format);
    QTextTableFormat format() const { return QTextObject::format().toTableFormat(); }

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    friend class QTextTableCell;
};

QT_END_NAMESPACE

#endif // QTEXTTABLE_H