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
public import QtCore.qstringlist;
public import QtCore.qshareddata;


#ifndef QT_NO_PROCESS

#if !defined(Q_OS_WIN) || defined(Q_QDOC)
typedef qint64 Q_PID;
#elsetypedef struct _PROCESS_INFORMATION *Q_PID;
QT_BEGIN_NAMESPACE
#endif

extern(C++) class QProcessPrivate;
extern(C++) class QProcessEnvironmentPrivate;

extern(C++) class export QProcessEnvironment
{
public:
    QProcessEnvironment();
    QProcessEnvironment(ref const(QProcessEnvironment) other);
    ~QProcessEnvironment();
    QProcessEnvironment &operator=(ref const(QProcessEnvironment) other);

    /+inline+/ void swap(QProcessEnvironment &other) { qSwap(d, other.d); }

    bool operator==(ref const(QProcessEnvironment) other) const;
    /+inline+/ bool operator!=(ref const(QProcessEnvironment) other) const
    { return !(*this == other); }

    bool isEmpty() const;
    void clear();

    bool contains(ref const(QString) name) const;
    void insert(ref const(QString) name, ref const(QString) value);
    void remove(ref const(QString) name);
    QString value(ref const(QString) name, ref const(QString) defaultValue = QString()) const;

    QStringList toStringList() const;

    QStringList keys() const;

    void insert(ref const(QProcessEnvironment) e);

    static QProcessEnvironment systemEnvironment();

private:
    friend extern(C++) class QProcessPrivate;
    friend extern(C++) class QProcessEnvironmentPrivate;
    QSharedDataPointer<QProcessEnvironmentPrivate> d;
}

Q_DECLARE_SHARED(QProcessEnvironment)

extern(C++) class export QProcess : QIODevice
{
    mixin Q_OBJECT;
public:
    enum ProcessError {
        FailedToStart, //### file not found, resource error
        Crashed,
        Timedout,
        ReadError,
        WriteError,
        UnknownError
    }
    enum ProcessState {
        NotRunning,
        Starting,
        Running
    }
    enum ProcessChannel {
        StandardOutput,
        StandardError
    }
    enum ProcessChannelMode {
        SeparateChannels,
        MergedChannels,
        ForwardedChannels,
        ForwardedOutputChannel,
        ForwardedErrorChannel
    }
    enum InputChannelMode {
        ManagedInputChannel,
        ForwardedInputChannel
    }
    enum ExitStatus {
        NormalExit,
        CrashExit
    }

    explicit QProcess(QObject *parent = 0);
    /+virtual+/ ~QProcess();

    void start(ref const(QString) program, ref const(QStringList) arguments, OpenMode mode = ReadWrite);
    void start(ref const(QString) command, OpenMode mode = ReadWrite);
    void start(OpenMode mode = ReadWrite);
    override bool open(OpenMode mode = ReadWrite);

    QString program() const;
    void setProgram(ref const(QString) program);

    QStringList arguments() const;
    void setArguments(ref const(QStringList)  arguments);

    ProcessChannelMode readChannelMode() const;
    void setReadChannelMode(ProcessChannelMode mode);
    ProcessChannelMode processChannelMode() const;
    void setProcessChannelMode(ProcessChannelMode mode);
    InputChannelMode inputChannelMode() const;
    void setInputChannelMode(InputChannelMode mode);

    ProcessChannel readChannel() const;
    void setReadChannel(ProcessChannel channel);

    void closeReadChannel(ProcessChannel channel);
    void closeWriteChannel();

    void setStandardInputFile(ref const(QString) fileName);
    void setStandardOutputFile(ref const(QString) fileName, OpenMode mode = Truncate);
    void setStandardErrorFile(ref const(QString) fileName, OpenMode mode = Truncate);
    void setStandardOutputProcess(QProcess *destination);

#if defined(Q_OS_WIN)
    QString nativeArguments() const;
    void setNativeArguments(ref const(QString) arguments);
#endif

    QString workingDirectory() const;
    void setWorkingDirectory(ref const(QString) dir);

    void setEnvironment(ref const(QStringList) environment);
    QStringList environment() const;
    void setProcessEnvironment(ref const(QProcessEnvironment) environment);
    QProcessEnvironment processEnvironment() const;

    QProcess::ProcessError error() const;
    QProcess::ProcessState state() const;

    // #### Qt 5: Q_PID is a pointer on Windows and a value on Unix
    Q_PID pid() const;
    qint64 processId() const;

    bool waitForStarted(int msecs = 30000);
    bool waitForReadyRead(int msecs = 30000);
    bool waitForBytesWritten(int msecs = 30000);
    bool waitForFinished(int msecs = 30000);

    QByteArray readAllStandardOutput();
    QByteArray readAllStandardError();

    int exitCode() const;
    QProcess::ExitStatus exitStatus() const;

    // QIODevice
    qint64 bytesAvailable() const;
    qint64 bytesToWrite() const;
    bool isSequential() const;
    bool canReadLine() const;
    void close();
    bool atEnd() const;

    static int execute(ref const(QString) program, ref const(QStringList) arguments);
    static int execute(ref const(QString) command);

    static bool startDetached(ref const(QString) program, ref const(QStringList) arguments,
                              ref const(QString) workingDirectory
#if defined(Q_QDOC)
                              = QString()
#endif
                              , qint64 *pid = 0);
#if !defined(Q_QDOC)
    static bool startDetached(ref const(QString) program, ref const(QStringList) arguments); // ### Qt6: merge overloads
#endif
    static bool startDetached(ref const(QString) command);

    static QStringList systemEnvironment();

    static QString nullDevice();

public Q_SLOTS:
    void terminate();
    void kill();

Q_SIGNALS:
    void started(
#if !defined(Q_QDOC)
        QPrivateSignal
#endif
    );
    void finished(int exitCode); // ### Qt 6: merge the two signals with a default value
    void finished(int exitCode, QProcess::ExitStatus exitStatus);
    void error(QProcess::ProcessError error);
    void stateChanged(QProcess::ProcessState state
#if !defined(Q_QDOC)
        , QPrivateSignal
#endif
    );

    void readyReadStandardOutput(
#if !defined(Q_QDOC)
        QPrivateSignal
#endif
    );
    void readyReadStandardError(
#if !defined(Q_QDOC)
        QPrivateSignal
#endif
    );

protected:
    void setProcessState(ProcessState state);

    /+virtual+/ void setupChildProcess();

    // QIODevice
    qint64 readData(char *data, qint64 maxlen);
    qint64 writeData(const(char)* data, qint64 len);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), bool _q_canReadStandardOutput())
    Q_PRIVATE_SLOT(d_func(), bool _q_canReadStandardError())
    Q_PRIVATE_SLOT(d_func(), bool _q_canWrite())
    Q_PRIVATE_SLOT(d_func(), bool _q_startupNotification())
    Q_PRIVATE_SLOT(d_func(), bool _q_processDied())
    Q_PRIVATE_SLOT(d_func(), void _q_notified())
    friend extern(C++) class QProcessManager;
}

#endif // QT_NO_PROCESS

#endif // QPROCESS_H
