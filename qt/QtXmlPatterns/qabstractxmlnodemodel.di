/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtXmlPatterns module of the Qt Toolkit.
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

#ifndef QABSTRACTXMLNODEMODEL_H
#define QABSTRACTXMLNODEMODEL_H

public import qt.QtXmlPatterns.QXmlName;
public import qt.QtCore.QSharedData;
public import qt.QtCore.QScopedPointer;

QT_BEGIN_NAMESPACE


/* This file contains the classes QXmlNodeModelIndex, QAbstractXmlNodeModel,
 * QXmlItem and QPatternist::NodeIndexStorage. */

class QAbstractXmlNodeModel;
class QAbstractXmlNodeModelPrivate;
class QAbstractXmlReceiver;
class QSourceLocation;
class QUrl;
class QXmlName;
class QXmlNodeModelIndex;
template<typename T> class QAbstractXmlForwardIterator;
template<typename T> class QVector;

/* The members in the namespace QPatternist are internal, not part of the public API, and
 * unsupported. Using them leads to undefined behavior. */
namespace QPatternist
{
    class DynamicContext;
    class Item;
    class ItemType;
    class XsdValidatedXmlNodeModel;
    template<typename TResult, typename TSource, typename TMapper, typename Context> class ItemMappingIterator;
    template<typename TResult, typename TSource, typename TMapper> class SequenceMappingIterator;
    typedef QExplicitlySharedDataPointer<ItemType> ItemTypePtr;
    typedef QExplicitlySharedDataPointer<QAbstractXmlForwardIterator<Item> > ItemIteratorPtr;
    typedef QVector<QXmlName> QXmlNameVector;

    class NodeIndexStorage
    {
    public:
        typedef qint64 Data;

        /*!
          \note Changing merely the order of these two members, ptr and data,
                is a binary incompatible change on Mac Power PC.
         */
        union
        {
            void *ptr; // Do not use ptr directy, use pointer() instead.
            Data data;
        };
        void *pointer() const
        {
            // Constructing via qptrdiff avoids warnings:
            return reinterpret_cast<void*>(qptrdiff(data));
        }

        Data additionalData;
        const(QAbstractXmlNodeModel)* model;

        /* Implementation is in qabstractxmlnodemodel.cpp. */
        /+inline+/ bool operator!=(ref const(NodeIndexStorage) other) const;

        void reset()
        {
            data = 0;
            additionalData = 0;
            model = 0;
        }
    };
}

class Q_XMLPATTERNS_EXPORT QXmlNodeModelIndex
{
    enum Constants
    {
        ForwardAxis         = 8192,
        ReverseAxis         = 16384
    };

public:
    /+inline+/ QXmlNodeModelIndex()
    {
        reset();
    }

    /+inline+/ QXmlNodeModelIndex(ref const(QXmlNodeModelIndex) other) : m_storage(other.m_storage)
    {
    }

    bool operator==(ref const(QXmlNodeModelIndex) other) const;
    bool operator!=(ref const(QXmlNodeModelIndex) other) const;

    typedef QAbstractXmlForwardIterator<QXmlNodeModelIndex> Iterator;
    typedef QList<QXmlNodeModelIndex> List;

    enum NodeKind
    {
        Attribute               = 1,
        Comment                 = 2,
        Document                = 4,
        Element                 = 8,
        Namespace               = 16,
        ProcessingInstruction   = 32,
        Text                    = 64
    };

    enum DocumentOrder
    {
        Precedes = -1,
        Is       = 0,
        Follows  = 1
    };

    enum Axis
    {
        AxisChild               = 1 | ForwardAxis,
        AxisDescendant          = 2 | ForwardAxis,
        AxisAttribute           = 4 | ForwardAxis,
        AxisSelf                = 8 | ForwardAxis,
        AxisDescendantOrSelf    = 16 | ForwardAxis,
        AxisFollowingSibling    = 32 | ForwardAxis,
        AxisNamespace           = 64 | ForwardAxis,
        AxisFollowing           = 128 | ReverseAxis,
        AxisParent              = 256 | ReverseAxis,
        AxisAncestor            = 512 | ReverseAxis,
        AxisPrecedingSibling    = 1024 | ReverseAxis,
        AxisPreceding           = 2048 | ReverseAxis,
        AxisAncestorOrSelf      = 4096 | ReverseAxis,
        /* Note that we cannot clash with the values of ForwardAxis and
         * ReverseAxis. */
        AxisChildOrTop          = 32768 | ForwardAxis,
        AxisAttributeOrTop      = 65536 | ForwardAxis
    };

    /+inline+/ qint64 data() const
    {
        return m_storage.data;
    }

    /+inline+/ void *internalPointer() const
    {
        return m_storage.pointer();
    }

    /+inline+/ const(QAbstractXmlNodeModel)* model() const
    {
        return m_storage.model;
    }

    /+inline+/ qint64 additionalData() const
    {
        return m_storage.additionalData;
    }

    /+inline+/ bool isNull() const
    {
        return !m_storage.model;
    }

    /* The members below are internal, not part of the public API, and
     * unsupported. Using them leads to undefined behavior. */

    /+inline+/ QXmlName name() const;
    /+inline+/ QXmlNodeModelIndex root() const;
    /+inline+/ QExplicitlySharedDataPointer<QAbstractXmlForwardIterator<QXmlNodeModelIndex> > iterate(const Axis axis) const;
    /+inline+/ QExplicitlySharedDataPointer<QAbstractXmlForwardIterator<QPatternist::Item> > sequencedTypedValue() const;
    /+inline+/ QUrl documentUri() const;
    /+inline+/ QUrl baseUri() const;
    /+inline+/ NodeKind kind() const;
    /+inline+/ bool isDeepEqual(ref const(QXmlNodeModelIndex) other) const;
    /+inline+/ DocumentOrder compareOrder(ref const(QXmlNodeModelIndex) other) const;
    /+inline+/ void sendNamespaces(QAbstractXmlReceiver *const receiver) const;
    /+inline+/ QVector<QXmlName> namespaceBindings() const;
    /+inline+/ QXmlName::NamespaceCode namespaceForPrefix(const QXmlName::PrefixCode prefix) const;
    /+inline+/ QString stringValue() const;
    /+inline+/ QPatternist::ItemTypePtr type() const;
    /+inline+/ bool is(ref const(QXmlNodeModelIndex) other) const;

    /+inline+/ void reset()
    {
        m_storage.reset();
    }

private:
    static /+inline+/ QXmlNodeModelIndex create(const qint64 d,
                                            const(QAbstractXmlNodeModel)* const nm)
    {
        QXmlNodeModelIndex n;
        n.m_storage.data = d;
        n.m_storage.model = nm;
        n.m_storage.additionalData = 0;
        return n;
    }

    static /+inline+/ QXmlNodeModelIndex create(const qint64 data,
                                            const(QAbstractXmlNodeModel)* const nm,
                                            const qint64 addData)
    {
        QXmlNodeModelIndex n;
        n.m_storage.data = data;
        n.m_storage.model = nm;
        n.m_storage.additionalData = addData;
        return n;
    }

    /+inline+/ QXmlNodeModelIndex(ref const(QPatternist::NodeIndexStorage) storage) : m_storage(storage)
    {
    }

    friend class QAbstractXmlNodeModel;
    friend class QPatternist::Item;
    friend class QXmlItem;
    /+inline+/ operator int() const; // Disable

    QPatternist::NodeIndexStorage m_storage;
};

Q_XMLPATTERNS_EXPORT uint qHash(ref const(QXmlNodeModelIndex) index);

/+inline+/ bool qIsForwardIteratorEnd(ref const(QXmlNodeModelIndex) item)
{
    return item.isNull();
}

class Q_XMLPATTERNS_EXPORT QAbstractXmlNodeModel : public QSharedData
{
public:
    enum SimpleAxis
    {
        Parent,
        FirstChild,
        PreviousSibling,
        NextSibling
    };

    typedef QExplicitlySharedDataPointer<QAbstractXmlNodeModel> Ptr;
    typedef QList<Ptr> List;

    QAbstractXmlNodeModel();
    /+virtual+/ ~QAbstractXmlNodeModel();

    /+virtual+/ QUrl baseUri(ref const(QXmlNodeModelIndex) ni) const = 0;
    /+virtual+/ QUrl documentUri(ref const(QXmlNodeModelIndex) ni) const = 0;
    /+virtual+/ QXmlNodeModelIndex::NodeKind kind(ref const(QXmlNodeModelIndex) ni) const = 0;
    /+virtual+/ QXmlNodeModelIndex::DocumentOrder compareOrder(ref const(QXmlNodeModelIndex) ni1,
                                                           ref const(QXmlNodeModelIndex) ni2) const = 0;
    /+virtual+/ QXmlNodeModelIndex root(ref const(QXmlNodeModelIndex) n) const = 0;
    /+virtual+/ QXmlName name(ref const(QXmlNodeModelIndex) ni) const = 0;
    /+virtual+/ QString stringValue(ref const(QXmlNodeModelIndex) n) const = 0;
    /+virtual+/ QVariant typedValue(ref const(QXmlNodeModelIndex) n) const = 0;

    /* The members below are internal, not part of the public API, and
     * unsupported. Using them leads to undefined behavior. */
    /+virtual+/ QExplicitlySharedDataPointer<QAbstractXmlForwardIterator<QXmlNodeModelIndex> > iterate(ref const(QXmlNodeModelIndex) ni, QXmlNodeModelIndex::Axis axis) const;
    /+virtual+/ QPatternist::ItemIteratorPtr sequencedTypedValue(ref const(QXmlNodeModelIndex) ni) const;
    /+virtual+/ QPatternist::ItemTypePtr type(ref const(QXmlNodeModelIndex) ni) const;
    /+virtual+/ QXmlName::NamespaceCode namespaceForPrefix(ref const(QXmlNodeModelIndex) ni,
                                                       const QXmlName::PrefixCode prefix) const;
    /+virtual+/ bool isDeepEqual(ref const(QXmlNodeModelIndex) ni1,
                             ref const(QXmlNodeModelIndex) ni2) const;
    /+virtual+/ void sendNamespaces(ref const(QXmlNodeModelIndex) n,
                                QAbstractXmlReceiver *const receiver) const;
    /+virtual+/ QVector<QXmlName> namespaceBindings(ref const(QXmlNodeModelIndex) n) const = 0;


    /+virtual+/ QXmlNodeModelIndex elementById(ref const(QXmlName) NCName) const = 0;
    /+virtual+/ QVector<QXmlNodeModelIndex> nodesByIdref(ref const(QXmlName) NCName) const = 0;

    enum NodeCopySetting
    {
        InheritNamespaces   = 0x1,
        PreserveNamespaces  = 0x2
    };

    typedef QFlags<NodeCopySetting> NodeCopySettings;
    /+virtual+/ void copyNodeTo(ref const(QXmlNodeModelIndex) node,
                            QAbstractXmlReceiver *const receiver,
                            ref const(NodeCopySettings) ) const;

    QSourceLocation sourceLocation(ref const(QXmlNodeModelIndex) index) const;

protected:

    /+virtual+/ QXmlNodeModelIndex nextFromSimpleAxis(SimpleAxis axis, ref const(QXmlNodeModelIndex) origin) const = 0;
    /+virtual+/ QVector<QXmlNodeModelIndex> attributes(ref const(QXmlNodeModelIndex) element) const = 0;

    QAbstractXmlNodeModel(QAbstractXmlNodeModelPrivate *d);

    /+inline+/ QXmlNodeModelIndex createIndex(qint64 data) const
    {
        return QXmlNodeModelIndex::create(data, this);
    }

    /+inline+/ QXmlNodeModelIndex createIndex(void * pointer,
                                          qint64 additionalData = 0) const
    {
        return QXmlNodeModelIndex::create(qptrdiff(pointer), this, additionalData);
    }

    /+inline+/ QXmlNodeModelIndex createIndex(qint64 data,
                                          qint64 additionalData) const
    {
        return QXmlNodeModelIndex::create(data, this, additionalData);
    }

    QScopedPointer<QAbstractXmlNodeModelPrivate> d_ptr;
private:
    friend class QPatternist::ItemMappingIterator<QXmlNodeModelIndex, QXmlNodeModelIndex, const(QAbstractXmlNodeModel)* , QExplicitlySharedDataPointer<QPatternist::DynamicContext> >;
    friend class QPatternist::SequenceMappingIterator<QXmlNodeModelIndex, QXmlNodeModelIndex, const(QAbstractXmlNodeModel)* >;
    friend class QPatternist::XsdValidatedXmlNodeModel;

    /+inline+/ QExplicitlySharedDataPointer<QAbstractXmlForwardIterator<QXmlNodeModelIndex> > mapToSequence(ref const(QXmlNodeModelIndex) ni,
                                                                           ref const(QExplicitlySharedDataPointer<QPatternist::DynamicContext>) ) const;

    static /+inline+/ bool isIgnorableInDeepEqual(ref const(QXmlNodeModelIndex) n);
    mixin Q_DISABLE_COPY;
};

Q_DECLARE_TYPEINFO(QXmlNodeModelIndex, Q_MOVABLE_TYPE);

template<typename T> class QAbstractXmlForwardIterator;
class QVariant;
class QXmlItemPrivate;

namespace QPatternist
{
    class AtomicValue;
    class VariableLoader;
    class IteratorBridge;
    class ToQXmlItemMapper;
    class ToItemMapper;
}

class Q_XMLPATTERNS_EXPORT QXmlItem
{
public:
    typedef QAbstractXmlForwardIterator<QXmlItem> Iterator;

    QXmlItem();
    QXmlItem(ref const(QXmlItem) other);
    QXmlItem(ref const(QXmlNodeModelIndex) node);
    QXmlItem(ref const(QVariant) atomicValue);
    ~QXmlItem();
    QXmlItem &operator=(ref const(QXmlItem) other);

    bool isNull() const;
    bool isNode() const;
    bool isAtomicValue() const;

    QVariant toAtomicValue() const;
    QXmlNodeModelIndex toNodeModelIndex() const;

private:
    friend class QPatternist::IteratorBridge;
    friend class QPatternist::VariableLoader;
    friend class QPatternist::ToQXmlItemMapper;
    friend class QPatternist::ToItemMapper;
    friend class QPatternist::Item;

    /+inline+/ bool internalIsAtomicValue() const;

    /+inline+/ QXmlItem(ref const(QPatternist::Item) i);

    union
    {
        QPatternist::NodeIndexStorage   m_node;

        /* These two sits at the position of NodeIndexStorage::data.
         * NodeIndexStorage::{additionalData,model} are free. */
        const QPatternist::AtomicValue *m_atomicValue;
        QXmlItemPrivate *               m_ptr; /* Not currently used. */
    };
};

/+inline+/ bool qIsForwardIteratorEnd(ref const(QXmlItem) item)
{
    return item.isNull();
}

Q_DECLARE_TYPEINFO(QXmlItem, Q_MOVABLE_TYPE);

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QXmlItem) /* This macro must appear after QT_END_NAMESPACE. */

#endif
