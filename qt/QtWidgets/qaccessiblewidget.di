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

#ifndef QACCESSIBLEWIDGET_H
#define QACCESSIBLEWIDGET_H

public import qt.QtGui.qaccessibleobject;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_ACCESSIBILITY

class QAccessibleWidgetPrivate;

class Q_WIDGETS_EXPORT QAccessibleWidget : public QAccessibleObject, public QAccessibleActionInterface
{
public:
    explicit QAccessibleWidget(QWidget *o, QAccessible::Role r = QAccessible::Client, ref const(QString) name = QString());
    bool isValid() const Q_DECL_OVERRIDE;

    QWindow *window() const Q_DECL_OVERRIDE;
    int childCount() const Q_DECL_OVERRIDE;
    int indexOfChild(const(QAccessibleInterface)* child) const Q_DECL_OVERRIDE;
    QVector<QPair<QAccessibleInterface*, QAccessible::Relation> > relations(QAccessible::Relation match = QAccessible::AllRelations) const Q_DECL_OVERRIDE;
    QAccessibleInterface *focusChild() const Q_DECL_OVERRIDE;

    QRect rect() const Q_DECL_OVERRIDE;

    QAccessibleInterface *parent() const Q_DECL_OVERRIDE;
    QAccessibleInterface *child(int index) const Q_DECL_OVERRIDE;

    QString text(QAccessible::Text t) const Q_DECL_OVERRIDE;
    QAccessible::Role role() const Q_DECL_OVERRIDE;
    QAccessible::State state() const Q_DECL_OVERRIDE;

    QColor foregroundColor() const Q_DECL_OVERRIDE;
    QColor backgroundColor() const Q_DECL_OVERRIDE;

    void *interface_cast(QAccessible::InterfaceType t) Q_DECL_OVERRIDE;

    // QAccessibleActionInterface
    QStringList actionNames() const Q_DECL_OVERRIDE;
    void doAction(ref const(QString) actionName) Q_DECL_OVERRIDE;
    QStringList keyBindingsForAction(ref const(QString) actionName) const Q_DECL_OVERRIDE;
protected:
    ~QAccessibleWidget();
    QWidget *widget() const;
    QObject *parentObject() const;

    void addControllingSignal(ref const(QString) signal);

private:
    QAccessibleWidgetPrivate *d;
    mixin Q_DISABLE_COPY;
};


#endif // QT_NO_ACCESSIBILITY

QT_END_NAMESPACE

#endif // QACCESSIBLEWIDGET_H
