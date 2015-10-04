/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2012 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com, author Giuseppe D'Angelo <giuseppe.dangelo@kdab.com>
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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

#ifndef QVALIDATOR_H
#define QVALIDATOR_H

public import qt.QtCore.qobject;
public import qt.QtCore.qstring;
public import qt.QtCore.qregexp;
public import qt.QtCore.qregularexpression;
public import qt.QtCore.qlocale;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_VALIDATOR

class QValidatorPrivate;

class Q_GUI_EXPORT QValidator : public QObject
{
    mixin Q_OBJECT;
public:
    explicit QValidator(QObject * parent = 0);
    ~QValidator();

    enum State {
        Invalid,
        Intermediate,
        Acceptable
    };

    void setLocale(ref const(QLocale) locale);
    QLocale locale() const;

    /+virtual+/ State validate(QString &, int &) const = 0;
    /+virtual+/ void fixup(QString &) const;

Q_SIGNALS:
    void changed();

protected:
    QValidator(QObjectPrivate &d, QObject *parent);
    QValidator(QValidatorPrivate &d, QObject *parent);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

class Q_GUI_EXPORT QIntValidator : public QValidator
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(int, "bottom", "READ", "bottom", "WRITE", "setBottom", "NOTIFY", "bottomChanged");
    mixin Q_PROPERTY!(int, "top", "READ", "top", "WRITE", "setTop", "NOTIFY", "topChanged");

public:
    explicit QIntValidator(QObject * parent = 0);
    QIntValidator(int bottom, int top, QObject *parent = 0);
    ~QIntValidator();

    QValidator::State validate(QString &, int &) const;
    void fixup(QString &input) const;

    void setBottom(int);
    void setTop(int);
    /+virtual+/ void setRange(int bottom, int top);

    int bottom() const { return b; }
    int top() const { return t; }
Q_SIGNALS:
    void bottomChanged(int bottom);
    void topChanged(int top);

private:
    mixin Q_DISABLE_COPY;

    int b;
    int t;
};

#ifndef QT_NO_REGEXP

class QDoubleValidatorPrivate;

class Q_GUI_EXPORT QDoubleValidator : public QValidator
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(double, "bottom", "READ", "bottom", "WRITE", "setBottom", "NOTIFY", "bottomChanged");
    mixin Q_PROPERTY!(double, "top", "READ", "top", "WRITE", "setTop", "NOTIFY", "topChanged");
    mixin Q_PROPERTY!(int, "decimals", "READ", "decimals", "WRITE", "setDecimals", "NOTIFY", "decimalsChanged");
    Q_ENUMS(Notation)
    mixin Q_PROPERTY!(Notation, "notation", "READ", "notation", "WRITE", "setNotation", "NOTIFY", "notationChanged");

public:
    explicit QDoubleValidator(QObject * parent = 0);
    QDoubleValidator(double bottom, double top, int decimals, QObject *parent = 0);
    ~QDoubleValidator();

    enum Notation {
        StandardNotation,
        ScientificNotation
    };
    QValidator::State validate(QString &, int &) const;

    /+virtual+/ void setRange(double bottom, double top, int decimals = 0);
    void setBottom(double);
    void setTop(double);
    void setDecimals(int);
    void setNotation(Notation);

    double bottom() const { return b; }
    double top() const { return t; }
    int decimals() const { return dec; }
    Notation notation() const;

Q_SIGNALS:
    void bottomChanged(double bottom);
    void topChanged(double top);
    void decimalsChanged(int decimals);
    void notationChanged(QDoubleValidator::Notation notation);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    double b;
    double t;
    int dec;
};


class Q_GUI_EXPORT QRegExpValidator : public QValidator
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QRegExp, "regExp", "READ", "regExp", "WRITE", "setRegExp", "NOTIFY", "regExpChanged");

public:
    explicit QRegExpValidator(QObject *parent = 0);
    explicit QRegExpValidator(ref const(QRegExp) rx, QObject *parent = 0);
    ~QRegExpValidator();

    /+virtual+/ QValidator::State validate(QString& input, int& pos) const;

    void setRegExp(ref const(QRegExp) rx);
    ref const(QRegExp) regExp() const { return r; }

Q_SIGNALS:
    void regExpChanged(ref const(QRegExp) regExp);

private:
    mixin Q_DISABLE_COPY;

    QRegExp r;
};

#endif // QT_NO_REGEXP

#ifndef QT_NO_REGULAREXPRESSION

class QRegularExpressionValidatorPrivate;

class Q_GUI_EXPORT QRegularExpressionValidator : public QValidator
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QRegularExpression, "regularExpression", "READ", "regularExpression", "WRITE", "setRegularExpression", "NOTIFY", "regularExpressionChanged");

public:
    explicit QRegularExpressionValidator(QObject *parent = 0);
    explicit QRegularExpressionValidator(ref const(QRegularExpression) re, QObject *parent = 0);
    ~QRegularExpressionValidator();

    /+virtual+/ QValidator::State validate(QString &input, int &pos) const Q_DECL_OVERRIDE;

    QRegularExpression regularExpression() const;

public Q_SLOTS:
    void setRegularExpression(ref const(QRegularExpression) re);

Q_SIGNALS:
    void regularExpressionChanged(ref const(QRegularExpression) re);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

#endif // QT_NO_REGULAREXPRESSION

#endif // QT_NO_VALIDATOR

QT_END_NAMESPACE

#endif // QVALIDATOR_H
