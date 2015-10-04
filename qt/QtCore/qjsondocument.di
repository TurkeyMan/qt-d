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

public import QtCore.qjsonvalue;

extern(C++) class QDebug;

namespace QJsonPrivate {
    extern(C++) class Parser;
}

struct export QJsonParseError
{
    enum ParseError {
        NoError = 0,
        UnterminatedObject,
        MissingNameSeparator,
        UnterminatedArray,
        MissingValueSeparator,
        IllegalValue,
        TerminationByNumber,
        IllegalNumber,
        IllegalEscapeSequence,
        IllegalUTF8String,
        UnterminatedString,
        MissingObject,
        DeepNesting,
        DocumentTooLarge,
        GarbageAtEnd
    }

    QString    errorString() const;

    int        offset;
    ParseError error;
}

extern(C++) class export QJsonDocument
{
public:
#ifdef Q_LITTLE_ENDIAN
    static const uint BinaryFormatTag = ('q') | ('b' << 8) | ('j' << 16) | ('s' << 24);
#else
    static const uint BinaryFormatTag = ('q' << 24) | ('b' << 16) | ('j' << 8) | ('s');
#endif

    QJsonDocument();
    explicit QJsonDocument(ref const(QJsonObject) object);
    explicit QJsonDocument(ref const(QJsonArray) array);
    ~QJsonDocument();

    QJsonDocument(ref const(QJsonDocument) other);
    QJsonDocument &operator =(ref const(QJsonDocument) other);

    enum DataValidation {
        Validate,
        BypassValidation
    }

    static QJsonDocument fromRawData(const(char)* data, int size, DataValidation validation = Validate);
    const(char)* rawData(int *size) const;

    static QJsonDocument fromBinaryData(ref const(QByteArray) data, DataValidation validation  = Validate);
    QByteArray toBinaryData() const;

    static QJsonDocument fromVariant(ref const(QVariant) variant);
    QVariant toVariant() const;

    enum JsonFormat {
        Indented,
        Compact
    }

    static QJsonDocument fromJson(ref const(QByteArray) json, QJsonParseError *error = 0);

#ifdef Q_QDOC
    QByteArray toJson(JsonFormat format = Indented) const;
#elif !defined(QT_JSON_READONLY)
    QByteArray toJson() const; //### Merge in Qt6
    QByteArray toJson(JsonFormat format) const;
#endif

    bool isEmpty() const;
    bool isArray() const;
    bool isObject() const;

    QJsonObject object() const;
    QJsonArray array() const;

    void setObject(ref const(QJsonObject) object);
    void setArray(ref const(QJsonArray) array);

    bool operator==(ref const(QJsonDocument) other) const;
    bool operator!=(ref const(QJsonDocument) other) const { return !(*this == other); }

    bool isNull() const;

private:
    friend extern(C++) class QJsonValue;
    friend extern(C++) class QJsonPrivate::Data;
    friend extern(C++) class QJsonPrivate::Parser;
    friend export QDebug operator<<(QDebug, ref const(QJsonDocument) );

    QJsonDocument(QJsonPrivate::Data *data);

    QJsonPrivate::Data *d;
}

#if !defined(QT_NO_DEBUG_STREAM) && !defined(QT_JSON_READONLY)
export QDebug operator<<(QDebug, ref const(QJsonDocument) );
#endif

#endif // QJSONDOCUMENT_H
