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

public import QtCore.qiodevice;
public import QtCore.qstring;
public import QtCore.qchar;
public import QtCore.qlocale;
public import QtCore.qscopedpointer;

public import stdio;

#ifdef Status
#error qtextstream.h must be included before any header file that defines Status
#endif


extern(C++) class QTextCodec;
extern(C++) class QTextDecoder;

extern(C++) class QTextStreamPrivate;
extern(C++) class export QTextStream                                // text stream class
{
    mixin Q_DECLARE_PRIVATE;

public:
    enum RealNumberNotation {
        SmartNotation,
        FixedNotation,
        ScientificNotation
    }
    enum FieldAlignment {
        AlignLeft,
        AlignRight,
        AlignCenter,
        AlignAccountingStyle
    }
    enum Status {
        Ok,
        ReadPastEnd,
        ReadCorruptData,
        WriteFailed
    }
    enum NumberFlag {
        ShowBase = 0x1,
        ForcePoint = 0x2,
        ForceSign = 0x4,
        UppercaseBase = 0x8,
        UppercaseDigits = 0x10
    }
    Q_DECLARE_FLAGS(NumberFlags, NumberFlag)

    QTextStream();
    explicit QTextStream(QIODevice *device);
    explicit QTextStream(FILE *fileHandle, QIODevice::OpenMode openMode = QIODevice::ReadWrite);
    explicit QTextStream(QString *string, QIODevice::OpenMode openMode = QIODevice::ReadWrite);
    explicit QTextStream(QByteArray *array, QIODevice::OpenMode openMode = QIODevice::ReadWrite);
    explicit QTextStream(ref const(QByteArray) array, QIODevice::OpenMode openMode = QIODevice::ReadOnly);
    /+virtual+/ ~QTextStream();

#ifndef QT_NO_TEXTCODEC
    void setCodec(QTextCodec *codec);
    void setCodec(const(char)* codecName);
    QTextCodec *codec() const;
    void setAutoDetectUnicode(bool enabled);
    bool autoDetectUnicode() const;
    void setGenerateByteOrderMark(bool generate);
    bool generateByteOrderMark() const;
#endif

    void setLocale(ref const(QLocale) locale);
    QLocale locale() const;

    void setDevice(QIODevice *device);
    QIODevice *device() const;

    void setString(QString *string, QIODevice::OpenMode openMode = QIODevice::ReadWrite);
    QString *string() const;

    Status status() const;
    void setStatus(Status status);
    void resetStatus();

    bool atEnd() const;
    void reset();
    void flush();
    bool seek(qint64 pos);
    qint64 pos() const;

    void skipWhiteSpace();

    QString readLine(qint64 maxlen = 0);
    QString readAll();
    QString read(qint64 maxlen);

    void setFieldAlignment(FieldAlignment alignment);
    FieldAlignment fieldAlignment() const;

    void setPadChar(QChar ch);
    QChar padChar() const;

    void setFieldWidth(int width);
    int fieldWidth() const;

    void setNumberFlags(NumberFlags flags);
    NumberFlags numberFlags() const;

    void setIntegerBase(int base);
    int integerBase() const;

    void setRealNumberNotation(RealNumberNotation notation);
    RealNumberNotation realNumberNotation() const;

    void setRealNumberPrecision(int precision);
    int realNumberPrecision() const;

    QTextStream &operator>>(QChar &ch);
    QTextStream &operator>>(char &ch);
    QTextStream &operator>>(signed short &i);
    QTextStream &operator>>(unsigned short &i);
    QTextStream &operator>>(signed int &i);
    QTextStream &operator>>(unsigned int &i);
    QTextStream &operator>>(signed long &i);
    QTextStream &operator>>(unsigned long &i);
    QTextStream &operator>>(qlonglong &i);
    QTextStream &operator>>(qulonglong &i);
    QTextStream &operator>>(float &f);
    QTextStream &operator>>(double &f);
    QTextStream &operator>>(QString &s);
    QTextStream &operator>>(QByteArray &array);
    QTextStream &operator>>(char *c);

    QTextStream &operator<<(QChar ch);
    QTextStream &operator<<(char ch);
    QTextStream &operator<<(signed short i);
    QTextStream &operator<<(unsigned short i);
    QTextStream &operator<<(signed int i);
    QTextStream &operator<<(unsigned int i);
    QTextStream &operator<<(signed long i);
    QTextStream &operator<<(unsigned long i);
    QTextStream &operator<<(qlonglong i);
    QTextStream &operator<<(qulonglong i);
    QTextStream &operator<<(float f);
    QTextStream &operator<<(double f);
    QTextStream &operator<<(ref const(QString) s);
    QTextStream &operator<<(QLatin1String s);
    QTextStream &operator<<(ref const(QByteArray) array);
    QTextStream &operator<<(const(char)* c);
    QTextStream &operator<<(const(void)* ptr);

private:
    mixin Q_DISABLE_COPY;
    friend extern(C++) class QDebugStateSaverPrivate;

    QScopedPointer<QTextStreamPrivate> d_ptr;
}

Q_DECLARE_OPERATORS_FOR_FLAGS(QTextStream::NumberFlags)

/*****************************************************************************
  QTextStream manipulators
 *****************************************************************************/

typedef QTextStream & (*QTextStreamFunction)(QTextStream &);// manipulator function
typedef void (QTextStream::*QTSMFI)(int); // manipulator w/int argument
typedef void (QTextStream::*QTSMFC)(QChar); // manipulator w/QChar argument


extern(C++) class export QTextStreamManipulator
{
public:
    QTextStreamManipulator(QTSMFI m, int a) { mf = m; mc = 0; arg = a; }
    QTextStreamManipulator(QTSMFC m, QChar c) { mf = 0; mc = m; ch = c; arg = -1; }
    void exec(QTextStream &s) { if (mf) { (s.*mf)(arg); } else { (s.*mc)(ch); } }

private:
    QTSMFI mf;                                        // QTextStream member function
    QTSMFC mc;                                        // QTextStream member function
    int arg;                                          // member function argument
    QChar ch;
}

/+inline+/ QTextStream &operator>>(QTextStream &s, QTextStreamFunction f)
{ return (*f)(s); }

/+inline+/ QTextStream &operator<<(QTextStream &s, QTextStreamFunction f)
{ return (*f)(s); }

/+inline+/ QTextStream &operator<<(QTextStream &s, QTextStreamManipulator m)
{ m.exec(s); return s; }

export QTextStream &bin(QTextStream &s);
export QTextStream &oct(QTextStream &s);
export QTextStream &dec(QTextStream &s);
export QTextStream &hex(QTextStream &s);

export QTextStream &showbase(QTextStream &s);
export QTextStream &forcesign(QTextStream &s);
export QTextStream &forcepoint(QTextStream &s);
export QTextStream &noshowbase(QTextStream &s);
export QTextStream &noforcesign(QTextStream &s);
export QTextStream &noforcepoint(QTextStream &s);

export QTextStream &uppercasebase(QTextStream &s);
export QTextStream &uppercasedigits(QTextStream &s);
export QTextStream &lowercasebase(QTextStream &s);
export QTextStream &lowercasedigits(QTextStream &s);

export QTextStream &fixed(QTextStream &s);
export QTextStream &scientific(QTextStream &s);

export QTextStream &left(QTextStream &s);
export QTextStream &right(QTextStream &s);
export QTextStream &center(QTextStream &s);

export QTextStream &endl(QTextStream &s);
export QTextStream &flush(QTextStream &s);
export QTextStream &reset(QTextStream &s);

export QTextStream &bom(QTextStream &s);

export QTextStream &ws(QTextStream &s);

/+inline+/ QTextStreamManipulator qSetFieldWidth(int width)
{
    QTSMFI func = &QTextStream::setFieldWidth;
    return QTextStreamManipulator(func,width);
}

/+inline+/ QTextStreamManipulator qSetPadChar(QChar ch)
{
    QTSMFC func = &QTextStream::setPadChar;
    return QTextStreamManipulator(func, ch);
}

/+inline+/ QTextStreamManipulator qSetRealNumberPrecision(int precision)
{
    QTSMFI func = &QTextStream::setRealNumberPrecision;
    return QTextStreamManipulator(func, precision);
}

#endif // QTEXTSTREAM_H
