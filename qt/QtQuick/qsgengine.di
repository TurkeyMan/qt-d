/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtQuick module of the Qt Toolkit.
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

public import QtCore.QObject;
public import QtQuick.qtquickglobal;

extern(C++) class QOpenGLContext;
extern(C++) class QSGAbstractRenderer;
extern(C++) class QSGEnginePrivate;
extern(C++) class QSGTexture;

extern(C++) class Q_QUICK_EXPORT QSGEngine : QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
public:
    enum CreateTextureOption {
        TextureHasAlphaChannel  = 0x0001,
        TextureOwnsGLTexture    = 0x0004,
        TextureCanUseAtlas      = 0x0008
    }
    Q_DECLARE_FLAGS(CreateTextureOptions, CreateTextureOption)

    QSGEngine(QObject *parent = 0);
    ~QSGEngine();

    void initialize(QOpenGLContext *context);
    void invalidate();

    QSGAbstractRenderer *createRenderer() const;
    QSGTexture *createTextureFromImage(ref const(QImage) image, CreateTextureOptions options = CreateTextureOption(0)) const;
    QSGTexture *createTextureFromId(uint id, ref const(QSize) size, CreateTextureOptions options = CreateTextureOption(0)) const;
}

#endif // QSGENGINE_H