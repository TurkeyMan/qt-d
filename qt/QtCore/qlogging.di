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

module qt.QtCore.qlogging;

public import qt.QtCore.qglobal;

/*
  Forward declarations only.

  In order to use the qDebug() stream, you must #include<QDebug>
*/
extern(C++) class QDebug;
extern(C++) class QNoDebug;

enum QtMsgType { QtDebugMsg, QtWarningMsg, QtCriticalMsg, QtFatalMsg, QtSystemMsg = QtCriticalMsg }

extern(C++) class QMessageLogContext
{
    mixin Q_DISABLE_COPY;
public:
    this() { _version = 2; }
    this(const(char)* fileName, int lineNumber, const(char)* functionName, const(char)* categoryName)
    {
        _version = 2;
        line = lineNumber;
        file = fileName;
        _function = functionName;
        category = categoryName;
    }

    void copy(ref const QMessageLogContext logContext);

    int _version;
    int line;
    const(char)* file;
    const(char)* _function;
    const(char)* category;
}

extern(C++) class QLoggingCategory;

export extern(C++) class QMessageLogger
{
    mixin Q_DISABLE_COPY;
public:
    this() {}
    this(const(char)* file, int line, const(char)* _function)
    {
        context(file, line, _function, "default");
    }
    this(const(char)* file, int line, const(char)* _function, const(char)* category)
    {
        context(file, line, _function, category);
    }

    void debug_(const(char)* msg, ...) const;
    void noDebug(const(char)* , ...) const {}
    void warning(const(char)* msg, ...) const;
    void critical(const(char)* msg, ...) const;

    alias CategoryFunction = ref const QLoggingCategory function();

    void debug_(ref const QLoggingCategory cat, const(char)* msg, ...) const;
    void debug_(CategoryFunction catFunc, const(char)* msg, ...) const;
    void warning(ref const QLoggingCategory cat, const(char)* msg, ...) const;
    void warning(CategoryFunction catFunc, const(char)* msg, ...) const;
    void critical(ref const QLoggingCategory cat, const(char)* msg, ...) const;
    void critical(CategoryFunction catFunc, const(char)* msg, ...) const;

    void fatal(const(char)* msg, ...) const nothrow;

version(QT_NO_DEBUG_STREAM) {} else {
    QDebug debug_() const;
    QDebug debug_(ref const QLoggingCategory cat) const;
    QDebug debug_(CategoryFunction catFunc) const;
    QDebug warning() const;
    QDebug warning(ref const QLoggingCategory cat) const;
    QDebug warning(CategoryFunction catFunc) const;
    QDebug critical() const;
    QDebug critical(ref const QLoggingCategory cat) const;
    QDebug critical(CategoryFunction catFunc) const;

    QNoDebug noDebug() const nothrow;
} // QT_NO_DEBUG_STREAM

private:
    QMessageLogContext context;
}

version(QT_NO_DEBUG) {
    version = QT_NO_MESSAGELOGCONTEXT;
} else {
    version = QT_MESSAGELOGCONTEXT;
}

version(QT_MESSAGELOGCONTEXT) {
  enum QT_MESSAGELOG_FILE(string File = __FILE__) = File;
  enum QT_MESSAGELOG_LINE(size_t Line = __LINE__) = Line;
  enum QT_MESSAGELOG_FUNC(string Func = __PRETTY_FUNCTION__) = Func;
} else {
  enum QT_MESSAGELOG_FILE(string File = null) = File;
  enum QT_MESSAGELOG_LINE(size_t Line = 0) = Line;
  enum QT_MESSAGELOG_FUNC(string Func = null) = Func;
}
/+
#define qDebug QMessageLogger(QT_MESSAGELOG_FILE!(), QT_MESSAGELOG_LINE!(), QT_MESSAGELOG_FUNC!()).debug
#define qWarning QMessageLogger(QT_MESSAGELOG_FILE!(), QT_MESSAGELOG_LINE!(), QT_MESSAGELOG_FUNC!()).warning
#define qCritical QMessageLogger(QT_MESSAGELOG_FILE!(), QT_MESSAGELOG_LINE!(), QT_MESSAGELOG_FUNC!()).critical
#define qFatal QMessageLogger(QT_MESSAGELOG_FILE!(), QT_MESSAGELOG_LINE!(), QT_MESSAGELOG_FUNC!()).fatal

#define QT_NO_QDEBUG_MACRO while (false) QMessageLogger().noDebug
#define QT_NO_QWARNING_MACRO while (false) QMessageLogger().noDebug

#if defined(QT_NO_DEBUG_OUTPUT)
#  undef qDebug
#  define qDebug QT_NO_QDEBUG_MACRO
#endif
#if defined(QT_NO_WARNING_OUTPUT)
#  undef qWarning
#  define qWarning QT_NO_QWARNING_MACRO
#endif
+/
export void qt_message_output(QtMsgType, ref const QMessageLogContext context, ref const QString message);

export void qErrnoWarning(int code, const(char)* msg, ...);
export void qErrnoWarning(const(char)* msg, ...);

static if(QT_DEPRECATED_SINCE(5, 0))// deprecated. Use qInstallMessageHandler instead!
{
    alias QtMsgHandler = void function(QtMsgType, const(char)*);
    deprecated export QtMsgHandler qInstallMsgHandler(QtMsgHandler);
}

alias QtMessageHandler = void function(QtMsgType, ref const QMessageLogContext, ref const QString);
export QtMessageHandler qInstallMessageHandler(QtMessageHandler);

export void qSetMessagePattern(ref const QString messagePattern);
export QString qFormatLogMessage(QtMsgType type, ref const QMessageLogContext context, ref const QString buf);
