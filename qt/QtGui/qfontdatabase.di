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

#ifndef QFONTDATABASE_H
#define QFONTDATABASE_H

public import qt.QtGui.qwindowdefs;
public import qt.QtCore.qstring;
public import qt.QtGui.qfont;

QT_BEGIN_NAMESPACE


class QStringList;
template <class T> class QList;
struct QFontDef;
class QFontEngine;

class QFontDatabasePrivate;

class Q_GUI_EXPORT QFontDatabase
{
    Q_GADGET
    Q_ENUMS(WritingSystem)
    Q_ENUMS(SystemFont)
public:
    // do not re-order or delete entries from this enum without updating the
    // QPF2 format and makeqpf!!
    enum WritingSystem {
        Any,

        Latin,
        Greek,
        Cyrillic,
        Armenian,
        Hebrew,
        Arabic,
        Syriac,
        Thaana,
        Devanagari,
        Bengali,
        Gurmukhi,
        Gujarati,
        Oriya,
        Tamil,
        Telugu,
        Kannada,
        Malayalam,
        Sinhala,
        Thai,
        Lao,
        Tibetan,
        Myanmar,
        Georgian,
        Khmer,
        SimplifiedChinese,
        TraditionalChinese,
        Japanese,
        Korean,
        Vietnamese,

        Symbol,
        Other = Symbol,

        Ogham,
        Runic,
        Nko,

        WritingSystemsCount
    };

    enum SystemFont {
        GeneralFont,
        FixedFont,
        TitleFont,
        SmallestReadableFont
    };

    static QList<int> standardSizes();

    QFontDatabase();

    QList<WritingSystem> writingSystems() const;
    QList<WritingSystem> writingSystems(ref const(QString) family) const;

    QStringList families(WritingSystem writingSystem = Any) const;
    QStringList styles(ref const(QString) family) const;
    QList<int> pointSizes(ref const(QString) family, ref const(QString) style = QString());
    QList<int> smoothSizes(ref const(QString) family, ref const(QString) style);
    QString styleString(ref const(QFont) font);
    QString styleString(ref const(QFontInfo) fontInfo);

    QFont font(ref const(QString) family, ref const(QString) style, int pointSize) const;

    bool isBitmapScalable(ref const(QString) family, ref const(QString) style = QString()) const;
    bool isSmoothlyScalable(ref const(QString) family, ref const(QString) style = QString()) const;
    bool isScalable(ref const(QString) family, ref const(QString) style = QString()) const;
    bool isFixedPitch(ref const(QString) family, ref const(QString) style = QString()) const;

    bool italic(ref const(QString) family, ref const(QString) style) const;
    bool bold(ref const(QString) family, ref const(QString) style) const;
    int weight(ref const(QString) family, ref const(QString) style) const;

    bool hasFamily(ref const(QString) family) const;

    static QString writingSystemName(WritingSystem writingSystem);
    static QString writingSystemSample(WritingSystem writingSystem);

    static int addApplicationFont(ref const(QString) fileName);
    static int addApplicationFontFromData(ref const(QByteArray) fontData);
    static QStringList applicationFontFamilies(int id);
    static bool removeApplicationFont(int id);
    static bool removeAllApplicationFonts();

#if QT_DEPRECATED_SINCE(5, 2)
    QT_DEPRECATED static bool supportsThreadedFontRendering();
#endif

    static QFont systemFont(SystemFont type);

private:
    static void createDatabase();
    static void parseFontName(ref const(QString) name, QString &foundry, QString &family);
    static QString resolveFontFamilyAlias(ref const(QString) family);
    static QFontEngine *findFont(int script, const(QFontPrivate)* fp, ref const(QFontDef) request, bool multi = false);
    static void load(const(QFontPrivate)* d, int script);

    friend struct QFontDef;
    friend class QFontPrivate;
    friend class QFontDialog;
    friend class QFontDialogPrivate;
    friend class QFontEngineMultiBasicImpl;

    QFontDatabasePrivate *d;
};

QT_END_NAMESPACE

#endif // QFONTDATABASE_H
