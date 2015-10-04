/****************************************************************************
**
** Copyright (C) 2013 Laszlo Papp <lpapp@kde.org>
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

public import QtCore.qstringlist;

public import QtCore.qcoreapplication;
public import QtCore.qcommandlineoption;

extern(C++) class QCommandLineParserPrivate;
extern(C++) class QCoreApplication;

extern(C++) class export QCommandLineParser
{
    Q_DECLARE_TR_FUNCTIONS(QCommandLineParser)
public:
    QCommandLineParser();
    ~QCommandLineParser();

    enum SingleDashWordOptionMode {
        ParseAsCompactedShortOptions,
        ParseAsLongOptions
    }
    void setSingleDashWordOptionMode(SingleDashWordOptionMode parsingMode);

    bool addOption(ref const(QCommandLineOption) commandLineOption);
    bool addOptions(ref const(QList<QCommandLineOption>) options);

    QCommandLineOption addVersionOption();
    QCommandLineOption addHelpOption();
    void setApplicationDescription(ref const(QString) description);
    QString applicationDescription() const;
    void addPositionalArgument(ref const(QString) name, ref const(QString) description, ref const(QString) syntax = QString());
    void clearPositionalArguments();

    void process(ref const(QStringList) arguments);
    void process(ref const(QCoreApplication) app);

    bool parse(ref const(QStringList) arguments);
    QString errorText() const;

    bool isSet(ref const(QString) name) const;
    QString value(ref const(QString) name) const;
    QStringList values(ref const(QString) name) const;

    bool isSet(ref const(QCommandLineOption) option) const;
    QString value(ref const(QCommandLineOption) option) const;
    QStringList values(ref const(QCommandLineOption) option) const;

    QStringList positionalArguments() const;
    QStringList optionNames() const;
    QStringList unknownOptionNames() const;

    Q_NORETURN void showVersion();
    Q_NORETURN void showHelp(int exitCode = 0);
    QString helpText() const;

private:
    mixin Q_DISABLE_COPY;

    QCommandLineParserPrivate * const d;
}

#endif // QCOMMANDLINEPARSER_H
