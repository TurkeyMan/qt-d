/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
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

#ifndef QUNDOSTACK_H
#define QUNDOSTACK_H

public import qt.QtCore.qobject;
public import qt.QtCore.qstring;

QT_BEGIN_NAMESPACE


class QAction;
class QUndoCommandPrivate;
class QUndoStackPrivate;

#ifndef QT_NO_UNDOCOMMAND

class Q_WIDGETS_EXPORT QUndoCommand
{
    QUndoCommandPrivate *d;

public:
    explicit QUndoCommand(QUndoCommand *parent = 0);
    explicit QUndoCommand(ref const(QString) text, QUndoCommand *parent = 0);
    /+virtual+/ ~QUndoCommand();

    /+virtual+/ void undo();
    /+virtual+/ void redo();

    QString text() const;
    QString actionText() const;
    void setText(ref const(QString) text);

    /+virtual+/ int id() const;
    /+virtual+/ bool mergeWith(const(QUndoCommand)* other);

    int childCount() const;
    const(QUndoCommand)* child(int index) const;

private:
    mixin Q_DISABLE_COPY;
    friend class QUndoStack;
};

#endif // QT_NO_UNDOCOMMAND

#ifndef QT_NO_UNDOSTACK

class Q_WIDGETS_EXPORT QUndoStack : public QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
    mixin Q_PROPERTY!(bool, "active", "READ", "isActive", "WRITE", "setActive");
    mixin Q_PROPERTY!(int, "undoLimit", "READ", "undoLimit", "WRITE", "setUndoLimit");

public:
    explicit QUndoStack(QObject *parent = 0);
    ~QUndoStack();
    void clear();

    void push(QUndoCommand *cmd);

    bool canUndo() const;
    bool canRedo() const;
    QString undoText() const;
    QString redoText() const;

    int count() const;
    int index() const;
    QString text(int idx) const;

#ifndef QT_NO_ACTION
    QAction *createUndoAction(QObject *parent,
                                ref const(QString) prefix = QString()) const;
    QAction *createRedoAction(QObject *parent,
                                ref const(QString) prefix = QString()) const;
#endif // QT_NO_ACTION

    bool isActive() const;
    bool isClean() const;
    int cleanIndex() const;

    void beginMacro(ref const(QString) text);
    void endMacro();

    void setUndoLimit(int limit);
    int undoLimit() const;

    const(QUndoCommand)* command(int index) const;

public Q_SLOTS:
    void setClean();
    void setIndex(int idx);
    void undo();
    void redo();
    void setActive(bool active = true);

Q_SIGNALS:
    void indexChanged(int idx);
    void cleanChanged(bool clean);
    void canUndoChanged(bool canUndo);
    void canRedoChanged(bool canRedo);
    void undoTextChanged(ref const(QString) undoText);
    void redoTextChanged(ref const(QString) redoText);

private:
    mixin Q_DISABLE_COPY;
    friend class QUndoGroup;
};

#endif // QT_NO_UNDOSTACK

QT_END_NAMESPACE

#endif // QUNDOSTACK_H
