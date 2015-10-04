/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
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

public import QtCore.qeasingcurve;
public import QtCore.qabstractanimation;
public import QtCore.qvector;
public import QtCore.qvariant;
public import QtCore.qpair;


#ifndef QT_NO_ANIMATION

extern(C++) class QVariantAnimationPrivate;
extern(C++) class export QVariantAnimation : QAbstractAnimation
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QVariant, "startValue", "READ", "startValue", "WRITE", "setStartValue");
    mixin Q_PROPERTY!(QVariant, "endValue", "READ", "endValue", "WRITE", "setEndValue");
    mixin Q_PROPERTY!(QVariant, "currentValue", "READ", "currentValue", "NOTIFY", "valueChanged");
    mixin Q_PROPERTY!(int, "duration", "READ", "duration", "WRITE", "setDuration");
    mixin Q_PROPERTY!(QEasingCurve, "easingCurve", "READ", "easingCurve", "WRITE", "setEasingCurve");

public:
    typedef QPair<qreal, QVariant> KeyValue;
    typedef QVector<KeyValue> KeyValues;

    QVariantAnimation(QObject *parent = 0);
    ~QVariantAnimation();

    QVariant startValue() const;
    void setStartValue(ref const(QVariant) value);

    QVariant endValue() const;
    void setEndValue(ref const(QVariant) value);

    QVariant keyValueAt(qreal step) const;
    void setKeyValueAt(qreal step, ref const(QVariant) value);

    KeyValues keyValues() const;
    void setKeyValues(ref const(KeyValues) values);

    QVariant currentValue() const;

    int duration() const;
    void setDuration(int msecs);

    QEasingCurve easingCurve() const;
    void setEasingCurve(ref const(QEasingCurve) easing);

    typedef QVariant (*Interpolator)(const(void)* from, const(void)* to, qreal progress);

Q_SIGNALS:
    void valueChanged(ref const(QVariant) value);

protected:
    QVariantAnimation(QVariantAnimationPrivate &dd, QObject *parent = 0);
    bool event(QEvent *event);

    void updateCurrentTime(int);
    void updateState(QAbstractAnimation::State newState, QAbstractAnimation::State oldState);

    /+virtual+/ void updateCurrentValue(ref const(QVariant) value);
    /+virtual+/ QVariant interpolated(ref const(QVariant) from, ref const(QVariant) to, qreal progress) const;

private:
    template <typename T> friend void qRegisterAnimationInterpolator(QVariant (*func)(ref const(T) , ref const(T) , qreal));
    static void registerInterpolator(Interpolator func, int interpolationType);

    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

template <typename T>
void qRegisterAnimationInterpolator(QVariant (*func)(ref const(T) from, ref const(T) to, qreal progress)) {
    QVariantAnimation::registerInterpolator(reinterpret_cast<QVariantAnimation::Interpolator>(func), qMetaTypeId<T>());
}

#endif //QT_NO_ANIMATION

#endif //QVARIANTANIMATION_H
