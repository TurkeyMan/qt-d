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

public import QtCore.qglobal;

#ifndef QT_NO_REGEXP

public import QtCore.qstring;


struct QRegExpPrivate;
extern(C++) class QStringList;

extern(C++) class export QRegExp
{
public:
    enum PatternSyntax {
        RegExp,
        Wildcard,
        FixedString,
        RegExp2,
        WildcardUnix,
        W3CXmlSchema11 }
    enum CaretMode { CaretAtZero, CaretAtOffset, CaretWontMatch }

    QRegExp();
    explicit QRegExp(ref const(QString) pattern, Qt.CaseSensitivity cs = Qt.CaseSensitive,
                     PatternSyntax syntax = RegExp);
    QRegExp(ref const(QRegExp) rx);
    ~QRegExp();
    QRegExp &operator=(ref const(QRegExp) rx);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QRegExp &operator=(QRegExp &&other)
    { qSwap(priv,other.priv); return *this; }
#endif
    /+inline+/ void swap(QRegExp &other) { qSwap(priv, other.priv); }

    bool operator==(ref const(QRegExp) rx) const;
    /+inline+/ bool operator!=(ref const(QRegExp) rx) const { return !operator==(rx); }

    bool isEmpty() const;
    bool isValid() const;
    QString pattern() const;
    void setPattern(ref const(QString) pattern);
    Qt.CaseSensitivity caseSensitivity() const;
    void setCaseSensitivity(Qt.CaseSensitivity cs);
    PatternSyntax patternSyntax() const;
    void setPatternSyntax(PatternSyntax syntax);

    bool isMinimal() const;
    void setMinimal(bool minimal);

    bool exactMatch(ref const(QString) str) const;

    int indexIn(ref const(QString) str, int offset = 0, CaretMode caretMode = CaretAtZero) const;
    int lastIndexIn(ref const(QString) str, int offset = -1, CaretMode caretMode = CaretAtZero) const;
    int matchedLength() const;
#ifndef QT_NO_REGEXP_CAPTURE
    int captureCount() const;
    QStringList capturedTexts() const;
    QStringList capturedTexts();
    QString cap(int nth = 0) const;
    QString cap(int nth = 0);
    int pos(int nth = 0) const;
    int pos(int nth = 0);
    QString errorString() const;
    QString errorString();
#endif

    static QString escape(ref const(QString) str);

private:
    QRegExpPrivate *priv;
}

Q_DECLARE_TYPEINFO(QRegExp, Q_MOVABLE_TYPE);

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &out, ref const(QRegExp) regExp);
export QDataStream &operator>>(QDataStream &in, QRegExp &regExp);
#endif

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QRegExp) );
#endif

#endif // QT_NO_REGEXP

#endif // QREGEXP_H
