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

#ifndef QCOMBOBOX_H
#define QCOMBOBOX_H

public import qt.QtWidgets.qwidget;
public import qt.QtWidgets.qabstractitemdelegate;
public import qt.QtCore.qabstractitemmodel;
public import qt.QtCore.qvariant;

QT_BEGIN_NAMESPACE

#ifndef QT_NO_COMBOBOX

class QAbstractItemView;
class QLineEdit;
class QComboBoxPrivate;
class QCompleter;

class Q_WIDGETS_EXPORT QComboBox : public QWidget
{
    mixin Q_OBJECT;

    Q_ENUMS(InsertPolicy)
    Q_ENUMS(SizeAdjustPolicy)
    mixin Q_PROPERTY!(bool, "editable", "READ", "isEditable", "WRITE", "setEditable");
    mixin Q_PROPERTY!(int, "count", "READ", "count");
    mixin Q_PROPERTY!(QString, "currentText", "READ", "currentText", "WRITE", "setCurrentText", "NOTIFY", "currentTextChanged", "USER", "true");
    mixin Q_PROPERTY!(int, "currentIndex", "READ", "currentIndex", "WRITE", "setCurrentIndex", "NOTIFY", "currentIndexChanged");
    mixin Q_PROPERTY!(QVariant, "currentData", "READ", "currentData");
    mixin Q_PROPERTY!(int, "maxVisibleItems", "READ", "maxVisibleItems", "WRITE", "setMaxVisibleItems");
    mixin Q_PROPERTY!(int, "maxCount", "READ", "maxCount", "WRITE", "setMaxCount");
    mixin Q_PROPERTY!(InsertPolicy, "insertPolicy", "READ", "insertPolicy", "WRITE", "setInsertPolicy");
    mixin Q_PROPERTY!(SizeAdjustPolicy, "sizeAdjustPolicy", "READ", "sizeAdjustPolicy", "WRITE", "setSizeAdjustPolicy");
    mixin Q_PROPERTY!(int, "minimumContentsLength", "READ", "minimumContentsLength", "WRITE", "setMinimumContentsLength");
    mixin Q_PROPERTY!(QSize, "iconSize", "READ", "iconSize", "WRITE", "setIconSize");

#ifndef QT_NO_COMPLETER
    mixin Q_PROPERTY!(bool, "autoCompletion", "READ", "autoCompletion", "WRITE", "setAutoCompletion", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(Qt.CaseSensitivity, "autoCompletionCaseSensitivity", "READ", "autoCompletionCaseSensitivity", "WRITE", "setAutoCompletionCaseSensitivity", "DESIGNABLE", "false");
#endif // QT_NO_COMPLETER

    mixin Q_PROPERTY!(bool, "duplicatesEnabled", "READ", "duplicatesEnabled", "WRITE", "setDuplicatesEnabled");
    mixin Q_PROPERTY!(bool, "frame", "READ", "hasFrame", "WRITE", "setFrame");
    mixin Q_PROPERTY!(int, "modelColumn", "READ", "modelColumn", "WRITE", "setModelColumn");

public:
    explicit QComboBox(QWidget *parent = 0);
    ~QComboBox();

    int maxVisibleItems() const;
    void setMaxVisibleItems(int maxItems);

    int count() const;
    void setMaxCount(int max);
    int maxCount() const;

#ifndef QT_NO_COMPLETER
    bool autoCompletion() const;
    void setAutoCompletion(bool enable);

    Qt.CaseSensitivity autoCompletionCaseSensitivity() const;
    void setAutoCompletionCaseSensitivity(Qt.CaseSensitivity sensitivity);
#endif

    bool duplicatesEnabled() const;
    void setDuplicatesEnabled(bool enable);

    void setFrame(bool);
    bool hasFrame() const;

    /+inline+/ int findText(ref const(QString) text,
                        Qt.MatchFlags flags = static_cast<Qt.MatchFlags>(Qt.MatchExactly|Qt.MatchCaseSensitive)) const
        { return findData(text, Qt.DisplayRole, flags); }
    int findData(ref const(QVariant) data, int role = Qt.UserRole,
                 Qt.MatchFlags flags = static_cast<Qt.MatchFlags>(Qt.MatchExactly|Qt.MatchCaseSensitive)) const;

    enum InsertPolicy {
        NoInsert,
        InsertAtTop,
        InsertAtCurrent,
        InsertAtBottom,
        InsertAfterCurrent,
        InsertBeforeCurrent,
        InsertAlphabetically
    };

    InsertPolicy insertPolicy() const;
    void setInsertPolicy(InsertPolicy policy);

    enum SizeAdjustPolicy {
        AdjustToContents,
        AdjustToContentsOnFirstShow,
        AdjustToMinimumContentsLength, // ### Qt 6: remove
        AdjustToMinimumContentsLengthWithIcon
    };

    SizeAdjustPolicy sizeAdjustPolicy() const;
    void setSizeAdjustPolicy(SizeAdjustPolicy policy);
    int minimumContentsLength() const;
    void setMinimumContentsLength(int characters);
    QSize iconSize() const;
    void setIconSize(ref const(QSize) size);

    bool isEditable() const;
    void setEditable(bool editable);
    void setLineEdit(QLineEdit *edit);
    QLineEdit *lineEdit() const;
#ifndef QT_NO_VALIDATOR
    void setValidator(const(QValidator)* v);
    const(QValidator)* validator() const;
#endif

#ifndef QT_NO_COMPLETER
    void setCompleter(QCompleter *c);
    QCompleter *completer() const;
#endif

    QAbstractItemDelegate *itemDelegate() const;
    void setItemDelegate(QAbstractItemDelegate *delegate);

    QAbstractItemModel *model() const;
    void setModel(QAbstractItemModel *model);

    QModelIndex rootModelIndex() const;
    void setRootModelIndex(ref const(QModelIndex) index);

    int modelColumn() const;
    void setModelColumn(int visibleColumn);

    int currentIndex() const;
    QString currentText() const;
    QVariant currentData(int role = Qt.UserRole) const;

    QString itemText(int index) const;
    QIcon itemIcon(int index) const;
    QVariant itemData(int index, int role = Qt.UserRole) const;

    /+inline+/ void addItem(ref const(QString) text, ref const(QVariant) userData = QVariant());
    /+inline+/ void addItem(ref const(QIcon) icon, ref const(QString) text,
                        ref const(QVariant) userData = QVariant());
    /+inline+/ void addItems(ref const(QStringList) texts)
        { insertItems(count(), texts); }

    /+inline+/ void insertItem(int index, ref const(QString) text, ref const(QVariant) userData = QVariant());
    void insertItem(int index, ref const(QIcon) icon, ref const(QString) text,
                    ref const(QVariant) userData = QVariant());
    void insertItems(int index, ref const(QStringList) texts);
    void insertSeparator(int index);

    void removeItem(int index);

    void setItemText(int index, ref const(QString) text);
    void setItemIcon(int index, ref const(QIcon) icon);
    void setItemData(int index, ref const(QVariant) value, int role = Qt.UserRole);

    QAbstractItemView *view() const;
    void setView(QAbstractItemView *itemView);

    QSize sizeHint() const;
    QSize minimumSizeHint() const;

    /+virtual+/ void showPopup();
    /+virtual+/ void hidePopup();

    bool event(QEvent *event);
    QVariant inputMethodQuery(Qt.InputMethodQuery) const;

public Q_SLOTS:
    void clear();
    void clearEditText();
    void setEditText(ref const(QString) text);
    void setCurrentIndex(int index);
    void setCurrentText(ref const(QString) text);

Q_SIGNALS:
    void editTextChanged(ref const(QString) );
    void activated(int index);
    void activated(ref const(QString) );
    void highlighted(int index);
    void highlighted(ref const(QString) );
    void currentIndexChanged(int index);
    void currentIndexChanged(ref const(QString) );
    void currentTextChanged(ref const(QString) );

protected:
    void focusInEvent(QFocusEvent *e);
    void focusOutEvent(QFocusEvent *e);
    void changeEvent(QEvent *e);
    void resizeEvent(QResizeEvent *e);
    void paintEvent(QPaintEvent *e);
    void showEvent(QShowEvent *e);
    void hideEvent(QHideEvent *e);
    void mousePressEvent(QMouseEvent *e);
    void mouseReleaseEvent(QMouseEvent *e);
    void keyPressEvent(QKeyEvent *e);
    void keyReleaseEvent(QKeyEvent *e);
#ifndef QT_NO_WHEELEVENT
    void wheelEvent(QWheelEvent *e);
#endif
    void contextMenuEvent(QContextMenuEvent *e);
    void inputMethodEvent(QInputMethodEvent *);
    void initStyleOption(QStyleOptionComboBox *option) const;


protected:
    QComboBox(QComboBoxPrivate &, QWidget *);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_itemSelected(ref const(QModelIndex) item))
    Q_PRIVATE_SLOT(d_func(), void _q_emitHighlighted(ref const(QModelIndex) ))
    Q_PRIVATE_SLOT(d_func(), void _q_emitCurrentIndexChanged(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_editingFinished())
    Q_PRIVATE_SLOT(d_func(), void _q_returnPressed())
    Q_PRIVATE_SLOT(d_func(), void _q_resetButton())
    Q_PRIVATE_SLOT(d_func(), void _q_dataChanged(ref const(QModelIndex) , ref const(QModelIndex) ))
    Q_PRIVATE_SLOT(d_func(), void _q_updateIndexBeforeChange())
    Q_PRIVATE_SLOT(d_func(), void _q_rowsInserted(ref const(QModelIndex)  parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_rowsRemoved(ref const(QModelIndex)  parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_modelDestroyed())
    Q_PRIVATE_SLOT(d_func(), void _q_modelReset())
#ifndef QT_NO_COMPLETER
    Q_PRIVATE_SLOT(d_func(), void _q_completerActivated(ref const(QModelIndex) index))
#endif
};

/+inline+/ void QComboBox::addItem(ref const(QString) atext, ref const(QVariant) auserData)
{ insertItem(count(), atext, auserData); }
/+inline+/ void QComboBox::addItem(ref const(QIcon) aicon, ref const(QString) atext,
                               ref const(QVariant) auserData)
{ insertItem(count(), aicon, atext, auserData); }

/+inline+/ void QComboBox::insertItem(int aindex, ref const(QString) atext,
                                  ref const(QVariant) auserData)
{ insertItem(aindex, QIcon(), atext, auserData); }

#endif // QT_NO_COMBOBOX

QT_END_NAMESPACE

#endif // QCOMBOBOX_H
