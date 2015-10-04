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

module qt.QtCore.qnumeric;

public import qt.QtCore.qglobal;

export bool qIsInf(double d);
export bool qIsNaN(double d);
export bool qIsFinite(double d);
export bool qIsInf(float f);
export bool qIsNaN(float f);
export bool qIsFinite(float f);
export double qSNaN();
export double qQNaN();
export double qInf();

export quint32 qFloatDistance(float a, float b);
export quint64 qFloatDistance(double a, double b);

/+
#define Q_INFINITY (QT_PREPEND_NAMESPACE(qInf)())
#define Q_SNAN (QT_PREPEND_NAMESPACE(qSNaN)())
#define Q_QNAN (QT_PREPEND_NAMESPACE(qQNaN)())
+/
alias Q_INFINITY = qInf;
alias Q_SNAN = qSNaN;
alias Q_QNAN = qQNaN;
