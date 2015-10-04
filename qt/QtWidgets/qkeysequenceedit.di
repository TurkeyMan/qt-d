/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2013 Ivan Komissarov.
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWidgets module of the Qt Toolkit.
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

#ifndef QKEYSEQUENCEEDIT_H
#define QKEYSEQUENCEEDIT_H

public import qt.QtWidgets.qwidget;

QT_BEGIN_NAMESPACE

#ifndef QT_NO_KEYSEQUENCEEDIT

class QKeySequenceEditPrivate;
class Q_WIDGETS_EXPORT QKeySequenceEdit : public QWidget
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QKeySequence, "keySequence", "READ", "keySequence", "WRITE", "setKeySequence", "NOTIFY", "keySequenceChanged", "USER", "true");

public:
    explicit QKeySequenceEdit(QWidget *parent = 0);
    explicit QKeySequenceEdit(ref const(QKeySequence) keySequence, QWidget *parent = 0);
    ~QKeySequenceEdit();

    QKeySequence keySequence() const;

public Q_SLOTS:
    void setKeySequence(ref const(QKeySequence) keySequence);
    void clear();

Q_SIGNALS:
    void editingFinished();
    void keySequenceChanged(ref const(QKeySequence) keySequence);

protected:
    QKeySequenceEdit(QKeySequenceEditPrivate &d, QWidget *parent, Qt.WindowFlags f);

    bool event(QEvent *) Q_DECL_OVERRIDE;
    void keyPressEvent(QKeyEvent *) Q_DECL_OVERRIDE;
    void keyReleaseEvent(QKeyEvent *) Q_DECL_OVERRIDE;
    void timerEvent(QTimerEvent *) Q_DECL_OVERRIDE;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

#endif // QT_NO_KEYSEQUENCEEDIT

QT_END_NAMESPACE

#endif // QKEYSEQUENCEEDIT_H