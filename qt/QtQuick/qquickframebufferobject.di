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

public import QtQuick.QQuickItem;


extern(C++) class QOpenGLFramebufferObject;
extern(C++) class QQuickFramebufferObjectPrivate;
extern(C++) class QSGFramebufferObjectNode;

extern(C++) class Q_QUICK_EXPORT QQuickFramebufferObject : QQuickItem
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

    mixin Q_PROPERTY!(bool, "textureFollowsItemSize", "READ", "textureFollowsItemSize", "WRITE", "setTextureFollowsItemSize", "NOTIFY", "textureFollowsItemSizeChanged");

public:

    extern(C++) class Q_QUICK_EXPORT Renderer {
    protected:
        Renderer();
        /+virtual+/ ~Renderer();
        /+virtual+/ void render() = 0;
        /+virtual+/ QOpenGLFramebufferObject *createFramebufferObject(ref const(QSize) size);
        /+virtual+/ void synchronize(QQuickFramebufferObject *);
        QOpenGLFramebufferObject *framebufferObject() const;
        void update();
        void invalidateFramebufferObject();
    private:
        friend extern(C++) class QSGFramebufferObjectNode;
        friend extern(C++) class QQuickFramebufferObject;
        void *data;
    }

    QQuickFramebufferObject(QQuickItem *parent = 0);

    bool textureFollowsItemSize() const;
    void setTextureFollowsItemSize(bool follows);

    /+virtual+/ Renderer *createRenderer() const = 0;

    override bool isTextureProvider() const;
    override QSGTextureProvider *textureProvider() const;
    override void releaseResources();

protected:
    void geometryChanged(ref const(QRectF) newGeometry, ref const(QRectF) oldGeometry);

protected:
    override QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);

Q_SIGNALS:
    void textureFollowsItemSizeChanged(bool);

private Q_SLOTS:
    void invalidateSceneGraph();
}

#endif // QQUICKFRAMEBUFFEROBJECT_H
