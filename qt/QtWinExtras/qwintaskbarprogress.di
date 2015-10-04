/****************************************************************************
 **
 ** Copyright (C) 2013 Ivan Vizir <define-true-false@yandex.com>
 ** Contact: http://www.qt-project.org/legal
 **
 ** This file is part of the QtWinExtras module of the Qt Toolkit.
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

#ifndef QWINTASKBARPROGRESS_H
#define QWINTASKBARPROGRESS_H

public import qt.QtCore.qobject;
public import qt.QtCore.qscopedpointer;
public import qt.QtWinExtras.qwinextrasglobal;

QT_BEGIN_NAMESPACE

class QWinTaskbarProgressPrivate;

class Q_WINEXTRAS_EXPORT QWinTaskbarProgress : public QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(int, "value", "READ", "value", "WRITE", "setValue", "NOTIFY", "valueChanged");
    mixin Q_PROPERTY!(int, "minimum", "READ", "minimum", "WRITE", "setMinimum", "NOTIFY", "minimumChanged");
    mixin Q_PROPERTY!(int, "maximum", "READ", "maximum", "WRITE", "setMaximum", "NOTIFY", "maximumChanged");
    mixin Q_PROPERTY!(bool, "visible", "READ", "isVisible", "WRITE", "setVisible", "NOTIFY", "visibilityChanged");
    mixin Q_PROPERTY!(bool, "paused", "READ", "isPaused", "WRITE", "setPaused", "NOTIFY", "pausedChanged");
    mixin Q_PROPERTY!(bool, "stopped", "READ", "isStopped", "NOTIFY", "stoppedChanged");

public:
    explicit QWinTaskbarProgress(QObject *parent = 0);
    ~QWinTaskbarProgress();

    int value() const;
    int minimum() const;
    int maximum() const;
    bool isVisible() const;
    bool isPaused() const;
    bool isStopped() const;

public Q_SLOTS:
    void setValue(int value);
    void setMinimum(int minimum);
    void setMaximum(int maximum);
    void setRange(int minimum, int maximum);
    void reset();
    void show();
    void hide();
    void setVisible(bool visible);
    void pause();
    void resume();
    void setPaused(bool paused);
    void stop();

Q_SIGNALS:
    void valueChanged(int value);
    void minimumChanged(int minimum);
    void maximumChanged(int maximum);
    void visibilityChanged(bool visible);
    void pausedChanged(bool paused);
    void stoppedChanged(bool stopped);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    QScopedPointer<QWinTaskbarProgressPrivate> d_ptr;
};

QT_END_NAMESPACE

#endif // QWINTASKBARPROGRESS_H
