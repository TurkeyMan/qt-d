/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Designer of the Qt Toolkit.
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

#ifndef ABSTRACTWIDGETBOX_H
#define ABSTRACTWIDGETBOX_H

public import qt.QtDesigner.sdk_global;

public import qt.QtCore.QSharedDataPointer;
public import qt.QtCore.QMetaType;
public import qt.QtWidgets.QWidget;
public import qt.QtGui.QIcon;

QT_BEGIN_NAMESPACE

class DomUI;
class QDesignerDnDItemInterface;

class QDesignerWidgetBoxWidgetData;

class QDESIGNER_SDK_EXPORT QDesignerWidgetBoxInterface : public QWidget
{
    mixin Q_OBJECT;
public:
    class QDESIGNER_SDK_EXPORT Widget {
    public:
        enum Type { Default, Custom };
        Widget(ref const(QString) aname = QString(), ref const(QString) xml = QString(),
                ref const(QString) icon_name = QString(), Type atype = Default);
        ~Widget();
        Widget(ref const(Widget) w);
        Widget &operator=(ref const(Widget) w);

        QString name() const;
        void setName(ref const(QString) aname);
        QString domXml() const;
        void setDomXml(ref const(QString) xml);
        QString iconName() const;
        void setIconName(ref const(QString) icon_name);
        Type type() const;
        void setType(Type atype);

        bool isNull() const;

    private:
        QSharedDataPointer<QDesignerWidgetBoxWidgetData> m_data;
    };

    typedef QList<Widget> WidgetList;

    class Category {
    public:
        enum Type { Default, Scratchpad };

        Category(ref const(QString) aname = QString(), Type atype = Default)
            : m_name(aname), m_type(atype) {}

        QString name() const { return m_name; }
        void setName(ref const(QString) aname) { m_name = aname; }
        int widgetCount() const { return m_widget_list.size(); }
        Widget widget(int idx) const { return m_widget_list.at(idx); }
        void removeWidget(int idx) { m_widget_list.removeAt(idx); }
        void addWidget(ref const(Widget) awidget) { m_widget_list.append(awidget); }
        Type type() const { return m_type; }
        void setType(Type atype) { m_type = atype; }

        bool isNull() const { return m_name.isEmpty(); }

    private:
        QString m_name;
        Type m_type;
        QList<Widget> m_widget_list;
    };
    typedef QList<Category> CategoryList;

    QDesignerWidgetBoxInterface(QWidget *parent = 0, Qt.WindowFlags flags = 0);
    /+virtual+/ ~QDesignerWidgetBoxInterface();

    /+virtual+/ int categoryCount() const = 0;
    /+virtual+/ Category category(int cat_idx) const = 0;
    /+virtual+/ void addCategory(ref const(Category) cat) = 0;
    /+virtual+/ void removeCategory(int cat_idx) = 0;

    /+virtual+/ int widgetCount(int cat_idx) const = 0;
    /+virtual+/ Widget widget(int cat_idx, int wgt_idx) const = 0;
    /+virtual+/ void addWidget(int cat_idx, ref const(Widget) wgt) = 0;
    /+virtual+/ void removeWidget(int cat_idx, int wgt_idx) = 0;

    int findOrInsertCategory(ref const(QString) categoryName);

    /+virtual+/ void dropWidgets(ref const(QList<QDesignerDnDItemInterface*>) item_list,
                                ref const(QPoint) global_mouse_pos) = 0;

    /+virtual+/ void setFileName(ref const(QString) file_name) = 0;
    /+virtual+/ QString fileName() const = 0;
    /+virtual+/ bool load() = 0;
    /+virtual+/ bool save() = 0;
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QT_PREPEND_NAMESPACE(QDesignerWidgetBoxInterface::Widget))

#endif // ABSTRACTWIDGETBOX_H
