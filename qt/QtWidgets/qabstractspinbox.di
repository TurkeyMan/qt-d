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

#ifndef QABSTRACTSPINBOX_H
#define QABSTRACTSPINBOX_H

public import qt.QtWidgets.qwidget;
public import qt.QtGui.qvalidator;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_SPINBOX

class QLineEdit;

class QAbstractSpinBoxPrivate;
class QStyleOptionSpinBox;

class Q_WIDGETS_EXPORT QAbstractSpinBox : public QWidget
{
    mixin Q_OBJECT;

    Q_ENUMS(ButtonSymbols)
    Q_ENUMS(CorrectionMode)
    mixin Q_PROPERTY!(bool, "wrapping", "READ", "wrapping", "WRITE", "setWrapping");
    mixin Q_PROPERTY!(bool, "frame", "READ", "hasFrame", "WRITE", "setFrame");
    mixin Q_PROPERTY!(Qt.Alignment, "alignment", "READ", "alignment", "WRITE", "setAlignment");
    mixin Q_PROPERTY!(bool, "readOnly", "READ", "isReadOnly", "WRITE", "setReadOnly");
    mixin Q_PROPERTY!(ButtonSymbols, "buttonSymbols", "READ", "buttonSymbols", "WRITE", "setButtonSymbols");
    mixin Q_PROPERTY!(QString, "specialValueText", "READ", "specialValueText", "WRITE", "setSpecialValueText");
    mixin Q_PROPERTY!(QString, "text", "READ", "text");
    mixin Q_PROPERTY!(bool, "accelerated", "READ", "isAccelerated", "WRITE", "setAccelerated");
    mixin Q_PROPERTY!(CorrectionMode, "correctionMode", "READ", "correctionMode", "WRITE", "setCorrectionMode");
    mixin Q_PROPERTY!(bool, "acceptableInput", "READ", "hasAcceptableInput");
    mixin Q_PROPERTY!(bool, "keyboardTracking", "READ", "keyboardTracking", "WRITE", "setKeyboardTracking");
    mixin Q_PROPERTY!(bool, "showGroupSeparator", "READ", "isGroupSeparatorShown", "WRITE", "setGroupSeparatorShown");
public:
    explicit QAbstractSpinBox(QWidget *parent = 0);
    ~QAbstractSpinBox();

    enum StepEnabledFlag { StepNone = 0x00, StepUpEnabled = 0x01,
                           StepDownEnabled = 0x02 };
    Q_DECLARE_FLAGS(StepEnabled, StepEnabledFlag)

    enum ButtonSymbols { UpDownArrows, PlusMinus, NoButtons };

    ButtonSymbols buttonSymbols() const;
    void setButtonSymbols(ButtonSymbols bs);

    enum CorrectionMode  { CorrectToPreviousValue, CorrectToNearestValue };

    void setCorrectionMode(CorrectionMode cm);
    CorrectionMode correctionMode() const;

    bool hasAcceptableInput() const;
    QString text() const;

    QString specialValueText() const;
    void setSpecialValueText(ref const(QString) txt);

    bool wrapping() const;
    void setWrapping(bool w);

    void setReadOnly(bool r);
    bool isReadOnly() const;

    void setKeyboardTracking(bool kt);
    bool keyboardTracking() const;

    void setAlignment(Qt.Alignment flag);
    Qt.Alignment alignment() const;

    void setFrame(bool);
    bool hasFrame() const;

    void setAccelerated(bool on);
    bool isAccelerated() const;

    void setGroupSeparatorShown(bool shown);
    bool isGroupSeparatorShown() const;

    QSize sizeHint() const;
    QSize minimumSizeHint() const;
    void interpretText();
    bool event(QEvent *event);

    QVariant inputMethodQuery(Qt.InputMethodQuery) const;

    /+virtual+/ QValidator::State validate(QString &input, int &pos) const;
    /+virtual+/ void fixup(QString &input) const;

    /+virtual+/ void stepBy(int steps);
public Q_SLOTS:
    void stepUp();
    void stepDown();
    void selectAll();
    /+virtual+/ void clear();
protected:
    void resizeEvent(QResizeEvent *event);
    void keyPressEvent(QKeyEvent *event);
    void keyReleaseEvent(QKeyEvent *event);
#ifndef QT_NO_WHEELEVENT
    void wheelEvent(QWheelEvent *event);
#endif
    void focusInEvent(QFocusEvent *event);
    void focusOutEvent(QFocusEvent *event);
    void contextMenuEvent(QContextMenuEvent *event);
    void changeEvent(QEvent *event);
    void closeEvent(QCloseEvent *event);
    void hideEvent(QHideEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    void timerEvent(QTimerEvent *event);
    void paintEvent(QPaintEvent *event);
    void showEvent(QShowEvent *event);
    void initStyleOption(QStyleOptionSpinBox *option) const;

    QLineEdit *lineEdit() const;
    void setLineEdit(QLineEdit *edit);

    /+virtual+/ StepEnabled stepEnabled() const;
Q_SIGNALS:
    void editingFinished();
protected:
    QAbstractSpinBox(QAbstractSpinBoxPrivate &dd, QWidget *parent = 0);

private:
    Q_PRIVATE_SLOT(d_func(), void _q_editorTextChanged(ref const(QString) ))
    Q_PRIVATE_SLOT(d_func(), void _q_editorCursorPositionChanged(int, int))

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    friend class QAccessibleAbstractSpinBox;
};
Q_DECLARE_OPERATORS_FOR_FLAGS(QAbstractSpinBox::StepEnabled)

#endif // QT_NO_SPINBOX

QT_END_NAMESPACE

#endif // QABSTRACTSPINBOX_H
