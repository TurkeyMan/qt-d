/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
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

public import QtCore.qchar;
public import QtCore.qstring;


extern(C++) class QTextBoundaryFinderPrivate;

extern(C++) class export QTextBoundaryFinder
{
public:
    QTextBoundaryFinder();
    QTextBoundaryFinder(ref const(QTextBoundaryFinder) other);
    QTextBoundaryFinder &operator=(ref const(QTextBoundaryFinder) other);
    ~QTextBoundaryFinder();

    enum BoundaryType {
        Grapheme,
        Word,
        Sentence,
        Line
    }

    enum BoundaryReason {
        NotAtBoundary = 0,
        BreakOpportunity = 0x1f,
        StartOfItem = 0x20,
        EndOfItem = 0x40,
        MandatoryBreak = 0x80,
        SoftHyphen = 0x100
    }
    Q_DECLARE_FLAGS( BoundaryReasons, BoundaryReason )

    QTextBoundaryFinder(BoundaryType type, ref const(QString) string);
    QTextBoundaryFinder(BoundaryType type, const(QChar)* chars, int length, unsigned char *buffer = 0, int bufferSize = 0);

    /+inline+/ bool isValid() const { return d; }

    /+inline+/ BoundaryType type() const { return t; }
    QString string() const;

    void toStart();
    void toEnd();
    int position() const;
    void setPosition(int position);

    int toNextBoundary();
    int toPreviousBoundary();

    bool isAtBoundary() const;
    BoundaryReasons boundaryReasons() const;

private:
    BoundaryType t;
    QString s;
    const(QChar)* chars;
    int length;
    int pos;
    uint freePrivate : 1;
    uint unused : 31;
    QTextBoundaryFinderPrivate *d;
}

Q_DECLARE_OPERATORS_FOR_FLAGS(QTextBoundaryFinder::BoundaryReasons)

#endif

