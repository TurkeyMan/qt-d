/****************************************************************************
**
** Copyright (C) 2012 Giuseppe D'Angelo <dangelog@gmail.com>.
** Copyright (C) 2012 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com, author Giuseppe D'Angelo <giuseppe.dangelo@kdab.com>
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

#ifndef QT_NO_REGULAREXPRESSION

public import QtCore.qstring;
public import QtCore.qstringlist;
public import QtCore.qshareddata;
public import QtCore.qvariant;

extern(C++) class QRegularExpressionMatch;
extern(C++) class QRegularExpressionMatchIterator;
struct QRegularExpressionPrivate;

extern(C++) class export QRegularExpression
{
public:
    enum PatternOption {
        NoPatternOption                = 0x0000,
        CaseInsensitiveOption          = 0x0001,
        DotMatchesEverythingOption     = 0x0002,
        MultilineOption                = 0x0004,
        ExtendedPatternSyntaxOption    = 0x0008,
        InvertedGreedinessOption       = 0x0010,
        DontCaptureOption              = 0x0020,
        UseUnicodePropertiesOption     = 0x0040,
        OptimizeOnFirstUsageOption     = 0x0080,
        DontAutomaticallyOptimizeOption = 0x0100
    }
    Q_DECLARE_FLAGS(PatternOptions, PatternOption)

    PatternOptions patternOptions() const;
    void setPatternOptions(PatternOptions options);

    QRegularExpression();
    explicit QRegularExpression(ref const(QString) pattern, PatternOptions options = NoPatternOption);
    QRegularExpression(ref const(QRegularExpression) re);
    ~QRegularExpression();
    QRegularExpression &operator=(ref const(QRegularExpression) re);

#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QRegularExpression &operator=(QRegularExpression &&re)
    { d.swap(re.d); return *this; }
#endif

    /+inline+/ void swap(QRegularExpression &re) { d.swap(re.d); }

    QString pattern() const;
    void setPattern(ref const(QString) pattern);

    bool isValid() const;
    int patternErrorOffset() const;
    QString errorString() const;

    int captureCount() const;
    QStringList namedCaptureGroups() const;

    enum MatchType {
        NormalMatch = 0,
        PartialPreferCompleteMatch,
        PartialPreferFirstMatch,
        NoMatch
    }

    enum MatchOption {
        NoMatchOption              = 0x0000,
        AnchoredMatchOption        = 0x0001,
        DontCheckSubjectStringMatchOption = 0x0002
    }
    Q_DECLARE_FLAGS(MatchOptions, MatchOption)

    QRegularExpressionMatch match(ref const(QString) subject,
                                  int offset                = 0,
                                  MatchType matchType       = NormalMatch,
                                  MatchOptions matchOptions = NoMatchOption) const;

    QRegularExpressionMatchIterator globalMatch(ref const(QString) subject,
                                                int offset                = 0,
                                                MatchType matchType       = NormalMatch,
                                                MatchOptions matchOptions = NoMatchOption) const;

    void optimize() const;

    static QString escape(ref const(QString) str);

    bool operator==(ref const(QRegularExpression) re) const;
    /+inline+/ bool operator!=(ref const(QRegularExpression) re) const { return !operator==(re); }

private:
    friend struct QRegularExpressionPrivate;
    friend extern(C++) class QRegularExpressionMatch;
    friend struct QRegularExpressionMatchPrivate;
    friend extern(C++) class QRegularExpressionMatchIterator;

    QRegularExpression(QRegularExpressionPrivate &dd);
    QExplicitlySharedDataPointer<QRegularExpressionPrivate> d;
}

Q_DECLARE_SHARED(QRegularExpression)
Q_DECLARE_OPERATORS_FOR_FLAGS(QRegularExpression::PatternOptions)
Q_DECLARE_OPERATORS_FOR_FLAGS(QRegularExpression::MatchOptions)

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &out, ref const(QRegularExpression) re);
export QDataStream &operator>>(QDataStream &in, QRegularExpression &re);
#endif

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug debug, ref const(QRegularExpression) re);
export QDebug operator<<(QDebug debug, QRegularExpression::PatternOptions patternOptions);
#endif

struct QRegularExpressionMatchPrivate;

extern(C++) class export QRegularExpressionMatch
{
public:
    QRegularExpressionMatch();
    ~QRegularExpressionMatch();
    QRegularExpressionMatch(ref const(QRegularExpressionMatch) match);
    QRegularExpressionMatch &operator=(ref const(QRegularExpressionMatch) match);

#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QRegularExpressionMatch &operator=(QRegularExpressionMatch &&match)
    { d.swap(match.d); return *this; }
#endif
    /+inline+/ void swap(QRegularExpressionMatch &match) { d.swap(match.d); }

    QRegularExpression regularExpression() const;
    QRegularExpression::MatchType matchType() const;
    QRegularExpression::MatchOptions matchOptions() const;

    bool hasMatch() const;
    bool hasPartialMatch() const;

    bool isValid() const;

    int lastCapturedIndex() const;

    QString captured(int nth = 0) const;
    QStringRef capturedRef(int nth = 0) const;

    QString captured(ref const(QString) name) const;
    QStringRef capturedRef(ref const(QString) name) const;

    QStringList capturedTexts() const;

    int capturedStart(int nth = 0) const;
    int capturedLength(int nth = 0) const;
    int capturedEnd(int nth = 0) const;

    int capturedStart(ref const(QString) name) const;
    int capturedLength(ref const(QString) name) const;
    int capturedEnd(ref const(QString) name) const;

private:
    friend extern(C++) class QRegularExpression;
    friend struct QRegularExpressionMatchPrivate;
    friend extern(C++) class QRegularExpressionMatchIterator;

    QRegularExpressionMatch(QRegularExpressionMatchPrivate &dd);
    QSharedDataPointer<QRegularExpressionMatchPrivate> d;
}

Q_DECLARE_SHARED(QRegularExpressionMatch)

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug debug, ref const(QRegularExpressionMatch) match);
#endif

struct QRegularExpressionMatchIteratorPrivate;

extern(C++) class export QRegularExpressionMatchIterator
{
public:
    QRegularExpressionMatchIterator();
    ~QRegularExpressionMatchIterator();
    QRegularExpressionMatchIterator(ref const(QRegularExpressionMatchIterator) iterator);
    QRegularExpressionMatchIterator &operator=(ref const(QRegularExpressionMatchIterator) iterator);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QRegularExpressionMatchIterator &operator=(QRegularExpressionMatchIterator &&iterator)
    { d.swap(iterator.d); return *this; }
#endif
    void swap(QRegularExpressionMatchIterator &iterator) { d.swap(iterator.d); }

    bool isValid() const;

    bool hasNext() const;
    QRegularExpressionMatch next();
    QRegularExpressionMatch peekNext() const;

    QRegularExpression regularExpression() const;
    QRegularExpression::MatchType matchType() const;
    QRegularExpression::MatchOptions matchOptions() const;

private:
    friend extern(C++) class QRegularExpression;

    QRegularExpressionMatchIterator(QRegularExpressionMatchIteratorPrivate &dd);
    QSharedDataPointer<QRegularExpressionMatchIteratorPrivate> d;
}

Q_DECLARE_SHARED(QRegularExpressionMatchIterator)

#endif // QT_NO_REGULAREXPRESSION

#endif // QREGULAREXPRESSION_H
