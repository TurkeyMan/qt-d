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

#ifndef QCOMPLETER_H
#define QCOMPLETER_H

public import qt.QtCore.qobject;
public import qt.QtCore.qpoint;
public import qt.QtCore.qstring;
public import qt.QtCore.qabstractitemmodel;
public import qt.QtCore.qrect;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_COMPLETER

class QCompleterPrivate;
class QAbstractItemView;
class QAbstractProxyModel;
class QWidget;

class Q_WIDGETS_EXPORT QCompleter : public QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "completionPrefix", "READ", "completionPrefix", "WRITE", "setCompletionPrefix");
    mixin Q_PROPERTY!(ModelSorting, "modelSorting", "READ", "modelSorting", "WRITE", "setModelSorting");
    mixin Q_PROPERTY!(Qt.MatchFlags, "filterMode", "READ", "filterMode", "WRITE", "setFilterMode");
    mixin Q_PROPERTY!(CompletionMode, "completionMode", "READ", "completionMode", "WRITE", "setCompletionMode");
    mixin Q_PROPERTY!(int, "completionColumn", "READ", "completionColumn", "WRITE", "setCompletionColumn");
    mixin Q_PROPERTY!(int, "completionRole", "READ", "completionRole", "WRITE", "setCompletionRole");
    mixin Q_PROPERTY!(int, "maxVisibleItems", "READ", "maxVisibleItems", "WRITE", "setMaxVisibleItems");
    mixin Q_PROPERTY!(Qt.CaseSensitivity, "caseSensitivity", "READ", "caseSensitivity", "WRITE", "setCaseSensitivity");
    mixin Q_PROPERTY!(bool, "wrapAround", "READ", "wrapAround", "WRITE", "setWrapAround");

public:
    enum CompletionMode {
        PopupCompletion,
        UnfilteredPopupCompletion,
        InlineCompletion
    };

    enum ModelSorting {
        UnsortedModel = 0,
        CaseSensitivelySortedModel,
        CaseInsensitivelySortedModel
    };

    QCompleter(QObject *parent = 0);
    QCompleter(QAbstractItemModel *model, QObject *parent = 0);
#ifndef QT_NO_STRINGLISTMODEL
    QCompleter(ref const(QStringList) completions, QObject *parent = 0);
#endif
    ~QCompleter();

    void setWidget(QWidget *widget);
    QWidget *widget() const;

    void setModel(QAbstractItemModel *c);
    QAbstractItemModel *model() const;

    void setCompletionMode(CompletionMode mode);
    CompletionMode completionMode() const;

    void setFilterMode(Qt.MatchFlags filterMode);
    Qt.MatchFlags filterMode() const;

    QAbstractItemView *popup() const;
    void setPopup(QAbstractItemView *popup);

    void setCaseSensitivity(Qt.CaseSensitivity caseSensitivity);
    Qt.CaseSensitivity caseSensitivity() const;

    void setModelSorting(ModelSorting sorting);
    ModelSorting modelSorting() const;

    void setCompletionColumn(int column);
    int  completionColumn() const;

    void setCompletionRole(int role);
    int  completionRole() const;

    bool wrapAround() const;

    int maxVisibleItems() const;
    void setMaxVisibleItems(int maxItems);

    int completionCount() const;
    bool setCurrentRow(int row);
    int currentRow() const;

    QModelIndex currentIndex() const;
    QString currentCompletion() const;

    QAbstractItemModel *completionModel() const;

    QString completionPrefix() const;

public Q_SLOTS:
    void setCompletionPrefix(ref const(QString) prefix);
    void complete(ref const(QRect) rect = QRect());
    void setWrapAround(bool wrap);

public:
    /+virtual+/ QString pathFromIndex(ref const(QModelIndex) index) const;
    /+virtual+/ QStringList splitPath(ref const(QString) path) const;

protected:
    bool eventFilter(QObject *o, QEvent *e);
    bool event(QEvent *);

Q_SIGNALS:
    void activated(ref const(QString) text);
    void activated(ref const(QModelIndex) index);
    void highlighted(ref const(QString) text);
    void highlighted(ref const(QModelIndex) index);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;

    Q_PRIVATE_SLOT(d_func(), void _q_complete(QModelIndex))
    Q_PRIVATE_SLOT(d_func(), void _q_completionSelected(ref const(QItemSelection)))
    Q_PRIVATE_SLOT(d_func(), void _q_autoResizePopup())
    Q_PRIVATE_SLOT(d_func(), void _q_fileSystemModelDirectoryLoaded(ref const(QString)))
};

#endif // QT_NO_COMPLETER

QT_END_NAMESPACE

#endif // QCOMPLETER_H
