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

public import QtCore.qobject;
public import QtCore.qbytearray;


#ifndef QT_NO_TRANSLATION

extern(C++) class QLocale;
extern(C++) class QTranslatorPrivate;

extern(C++) class export QTranslator : QObject
{
    mixin Q_OBJECT;
public:
    explicit QTranslator(QObject *parent = 0);
    ~QTranslator();

    /+virtual+/ QString translate(const(char)* context, const(char)* sourceText,
                              const(char)* disambiguation = 0, int n = -1) const;

    /+virtual+/ bool isEmpty() const;

    bool load(ref const(QString)  filename,
              ref const(QString)  directory = QString(),
              ref const(QString)  search_delimiters = QString(),
              ref const(QString)  suffix = QString());
    bool load(ref const(QLocale)  locale,
              ref const(QString)  filename,
              ref const(QString)  prefix = QString(),
              ref const(QString)  directory = QString(),
              ref const(QString)  suffix = QString());
    bool load(const(uchar)* data, int len, ref const(QString) directory = QString());

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

#endif // QT_NO_TRANSLATION

#endif // QTRANSLATOR_H
