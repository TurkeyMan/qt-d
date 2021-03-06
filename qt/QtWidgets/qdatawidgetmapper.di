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

#ifndef QDATAWIDGETMAPPER_H
#define QDATAWIDGETMAPPER_H

public import qt.QtCore.qobject;

#ifndef QT_NO_DATAWIDGETMAPPER

QT_BEGIN_NAMESPACE


class QAbstractItemDelegate;
class QAbstractItemModel;
class QModelIndex;
class QDataWidgetMapperPrivate;

class Q_WIDGETS_EXPORT QDataWidgetMapper: public QObject
{
    mixin Q_OBJECT;

    Q_ENUMS(SubmitPolicy)
    mixin Q_PROPERTY!(int, "currentIndex", "READ", "currentIndex", "WRITE", "setCurrentIndex", "NOTIFY", "currentIndexChanged");
    mixin Q_PROPERTY!(Qt.Orientation, "orientation", "READ", "orientation", "WRITE", "setOrientation");
    mixin Q_PROPERTY!(SubmitPolicy, "submitPolicy", "READ", "submitPolicy", "WRITE", "setSubmitPolicy");

public:
    explicit QDataWidgetMapper(QObject *parent = 0);
    ~QDataWidgetMapper();

    void setModel(QAbstractItemModel *model);
    QAbstractItemModel *model() const;

    void setItemDelegate(QAbstractItemDelegate *delegate);
    QAbstractItemDelegate *itemDelegate() const;

    void setRootIndex(ref const(QModelIndex) index);
    QModelIndex rootIndex() const;

    void setOrientation(Qt.Orientation aOrientation);
    Qt.Orientation orientation() const;

    enum SubmitPolicy { AutoSubmit, ManualSubmit };
    void setSubmitPolicy(SubmitPolicy policy);
    SubmitPolicy submitPolicy() const;

    void addMapping(QWidget *widget, int section);
    void addMapping(QWidget *widget, int section, ref const(QByteArray) propertyName);
    void removeMapping(QWidget *widget);
    int mappedSection(QWidget *widget) const;
    QByteArray mappedPropertyName(QWidget *widget) const;
    QWidget *mappedWidgetAt(int section) const;
    void clearMapping();

    int currentIndex() const;

public Q_SLOTS:
    void revert();
    bool submit();

    void toFirst();
    void toLast();
    void toNext();
    void toPrevious();
    /+virtual+/ void setCurrentIndex(int index);
    void setCurrentModelIndex(ref const(QModelIndex) index);

Q_SIGNALS:
    void currentIndexChanged(int index);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_dataChanged(ref const(QModelIndex) , ref const(QModelIndex) , ref const(QVector<int>) ))
    Q_PRIVATE_SLOT(d_func(), void _q_commitData(QWidget *))
    Q_PRIVATE_SLOT(d_func(), void _q_closeEditor(QWidget *, QAbstractItemDelegate::EndEditHint))
    Q_PRIVATE_SLOT(d_func(), void _q_modelDestroyed())
};

QT_END_NAMESPACE

#endif // QT_NO_DATAWIDGETMAPPER
#endif

