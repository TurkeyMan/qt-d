/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtXml module of the Qt Toolkit.
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

#ifndef QDOM_H
#define QDOM_H

public import qt.QtXml.qtxmlglobal;
public import qt.QtCore.qstring;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_DOM

class QIODevice;
class QTextStream;

class QXmlInputSource;
class QXmlReader;

class QDomDocumentPrivate;
class QDomDocumentTypePrivate;
class QDomDocumentFragmentPrivate;
class QDomNodePrivate;
class QDomNodeListPrivate;
class QDomImplementationPrivate;
class QDomElementPrivate;
class QDomNotationPrivate;
class QDomEntityPrivate;
class QDomEntityReferencePrivate;
class QDomProcessingInstructionPrivate;
class QDomAttrPrivate;
class QDomCharacterDataPrivate;
class QDomTextPrivate;
class QDomCommentPrivate;
class QDomCDATASectionPrivate;
class QDomNamedNodeMapPrivate;
class QDomImplementationPrivate;

class QDomNodeList;
class QDomElement;
class QDomText;
class QDomComment;
class QDomCDATASection;
class QDomProcessingInstruction;
class QDomAttr;
class QDomEntityReference;
class QDomDocument;
class QDomNamedNodeMap;
class QDomDocument;
class QDomDocumentFragment;
class QDomDocumentType;
class QDomImplementation;
class QDomNode;
class QDomEntity;
class QDomNotation;
class QDomCharacterData;

class Q_XML_EXPORT QDomImplementation
{
public:
    QDomImplementation();
    QDomImplementation(ref const(QDomImplementation));
    ~QDomImplementation();
    QDomImplementation& operator= (ref const(QDomImplementation));
    bool operator== (ref const(QDomImplementation)) const;
    bool operator!= (ref const(QDomImplementation)) const;

    // functions
    bool hasFeature(ref const(QString) feature, ref const(QString) version) const;
    QDomDocumentType createDocumentType(ref const(QString) qName, ref const(QString) publicId, ref const(QString) systemId);
    QDomDocument createDocument(ref const(QString) nsURI, ref const(QString) qName, ref const(QDomDocumentType) doctype);

    enum InvalidDataPolicy { AcceptInvalidChars = 0, DropInvalidChars, ReturnNullNode };
    static InvalidDataPolicy invalidDataPolicy();
    static void setInvalidDataPolicy(InvalidDataPolicy policy);

    // Qt extension
    bool isNull();

private:
    QDomImplementationPrivate* impl;
    QDomImplementation(QDomImplementationPrivate*);

    friend class QDomDocument;
};

class Q_XML_EXPORT QDomNode
{
public:
    enum NodeType {
        ElementNode               = 1,
        AttributeNode             = 2,
        TextNode                  = 3,
        CDATASectionNode          = 4,
        EntityReferenceNode       = 5,
        EntityNode                = 6,
        ProcessingInstructionNode = 7,
        CommentNode               = 8,
        DocumentNode              = 9,
        DocumentTypeNode          = 10,
        DocumentFragmentNode      = 11,
        NotationNode              = 12,
        BaseNode                  = 21,// this is not in the standard
        CharacterDataNode         = 22 // this is not in the standard
    };

    enum EncodingPolicy
    {
        EncodingFromDocument      = 1,
        EncodingFromTextStream    = 2
    };

    QDomNode();
    QDomNode(ref const(QDomNode));
    QDomNode& operator= (ref const(QDomNode));
    bool operator== (ref const(QDomNode)) const;
    bool operator!= (ref const(QDomNode)) const;
    ~QDomNode();

    // DOM functions
    QDomNode insertBefore(ref const(QDomNode) newChild, ref const(QDomNode) refChild);
    QDomNode insertAfter(ref const(QDomNode) newChild, ref const(QDomNode) refChild);
    QDomNode replaceChild(ref const(QDomNode) newChild, ref const(QDomNode) oldChild);
    QDomNode removeChild(ref const(QDomNode) oldChild);
    QDomNode appendChild(ref const(QDomNode) newChild);
    bool hasChildNodes() const;
    QDomNode cloneNode(bool deep = true) const;
    void normalize();
    bool isSupported(ref const(QString) feature, ref const(QString) version) const;

    // DOM read-only attributes
    QString nodeName() const;
    NodeType nodeType() const;
    QDomNode parentNode() const;
    QDomNodeList childNodes() const;
    QDomNode firstChild() const;
    QDomNode lastChild() const;
    QDomNode previousSibling() const;
    QDomNode nextSibling() const;
    QDomNamedNodeMap attributes() const;
    QDomDocument ownerDocument() const;
    QString namespaceURI() const;
    QString localName() const;
    bool hasAttributes() const;

    // DOM attributes
    QString nodeValue() const;
    void setNodeValue(ref const(QString));
    QString prefix() const;
    void setPrefix(ref const(QString) pre);

    // Qt extensions
    bool isAttr() const;
    bool isCDATASection() const;
    bool isDocumentFragment() const;
    bool isDocument() const;
    bool isDocumentType() const;
    bool isElement() const;
    bool isEntityReference() const;
    bool isText() const;
    bool isEntity() const;
    bool isNotation() const;
    bool isProcessingInstruction() const;
    bool isCharacterData() const;
    bool isComment() const;

    /**
     * Shortcut to avoid dealing with QDomNodeList
     * all the time.
     */
    QDomNode namedItem(ref const(QString) name) const;

    bool isNull() const;
    void clear();

    QDomAttr toAttr() const;
    QDomCDATASection toCDATASection() const;
    QDomDocumentFragment toDocumentFragment() const;
    QDomDocument toDocument() const;
    QDomDocumentType toDocumentType() const;
    QDomElement toElement() const;
    QDomEntityReference toEntityReference() const;
    QDomText toText() const;
    QDomEntity toEntity() const;
    QDomNotation toNotation() const;
    QDomProcessingInstruction toProcessingInstruction() const;
    QDomCharacterData toCharacterData() const;
    QDomComment toComment() const;

    void save(QTextStream&, int, EncodingPolicy=QDomNode::EncodingFromDocument) const;

    QDomElement firstChildElement(ref const(QString) tagName = QString()) const;
    QDomElement lastChildElement(ref const(QString) tagName = QString()) const;
    QDomElement previousSiblingElement(ref const(QString) tagName = QString()) const;
    QDomElement nextSiblingElement(ref const(QString) taName = QString()) const;

    int lineNumber() const;
    int columnNumber() const;

protected:
    QDomNodePrivate* impl;
    QDomNode(QDomNodePrivate*);

private:
    friend class QDomDocument;
    friend class QDomDocumentType;
    friend class QDomNodeList;
    friend class QDomNamedNodeMap;
};

class Q_XML_EXPORT QDomNodeList
{
public:
    QDomNodeList();
    QDomNodeList(ref const(QDomNodeList));
    QDomNodeList& operator= (ref const(QDomNodeList));
    bool operator== (ref const(QDomNodeList)) const;
    bool operator!= (ref const(QDomNodeList)) const;
    ~QDomNodeList();

    // DOM functions
    QDomNode item(int index) const;
    /+inline+/ QDomNode at(int index) const { return item(index); } // Qt API consistency

    // DOM read only attributes
    int length() const;
    /+inline+/ int count() const { return length(); } // Qt API consitancy
    /+inline+/ int size() const { return length(); } // Qt API consistency
    /+inline+/ bool isEmpty() const { return length() == 0; } // Qt API consistency

private:
    QDomNodeListPrivate* impl;
    QDomNodeList(QDomNodeListPrivate*);

    friend class QDomNode;
    friend class QDomElement;
    friend class QDomDocument;
};

class Q_XML_EXPORT QDomDocumentType : public QDomNode
{
public:
    QDomDocumentType();
    QDomDocumentType(ref const(QDomDocumentType) x);
    QDomDocumentType& operator= (ref const(QDomDocumentType));

    // DOM read only attributes
    QString name() const;
    QDomNamedNodeMap entities() const;
    QDomNamedNodeMap notations() const;
    QString publicId() const;
    QString systemId() const;
    QString internalSubset() const;

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return DocumentTypeNode; }

private:
    QDomDocumentType(QDomDocumentTypePrivate*);

    friend class QDomImplementation;
    friend class QDomDocument;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomDocument : public QDomNode
{
public:
    QDomDocument();
    explicit QDomDocument(ref const(QString) name);
    explicit QDomDocument(ref const(QDomDocumentType) doctype);
    QDomDocument(ref const(QDomDocument) x);
    QDomDocument& operator= (ref const(QDomDocument));
    ~QDomDocument();

    // DOM functions
    QDomElement createElement(ref const(QString) tagName);
    QDomDocumentFragment createDocumentFragment();
    QDomText createTextNode(ref const(QString) data);
    QDomComment createComment(ref const(QString) data);
    QDomCDATASection createCDATASection(ref const(QString) data);
    QDomProcessingInstruction createProcessingInstruction(ref const(QString) target, ref const(QString) data);
    QDomAttr createAttribute(ref const(QString) name);
    QDomEntityReference createEntityReference(ref const(QString) name);
    QDomNodeList elementsByTagName(ref const(QString) tagname) const;
    QDomNode importNode(ref const(QDomNode) importedNode, bool deep);
    QDomElement createElementNS(ref const(QString) nsURI, ref const(QString) qName);
    QDomAttr createAttributeNS(ref const(QString) nsURI, ref const(QString) qName);
    QDomNodeList elementsByTagNameNS(ref const(QString) nsURI, ref const(QString) localName);
    QDomElement elementById(ref const(QString) elementId);

    // DOM read only attributes
    QDomDocumentType doctype() const;
    QDomImplementation implementation() const;
    QDomElement documentElement() const;

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return DocumentNode; }

    // Qt extensions
    bool setContent(ref const(QByteArray) text, bool namespaceProcessing, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );
    bool setContent(ref const(QString) text, bool namespaceProcessing, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );
    bool setContent(QIODevice* dev, bool namespaceProcessing, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );
    bool setContent(QXmlInputSource *source, bool namespaceProcessing, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );
    bool setContent(ref const(QByteArray) text, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );
    bool setContent(ref const(QString) text, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );
    bool setContent(QIODevice* dev, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );
    bool setContent(QXmlInputSource *source, QXmlReader *reader, QString *errorMsg=0, int *errorLine=0, int *errorColumn=0 );

    // Qt extensions
    QString toString(int = 1) const;
    QByteArray toByteArray(int = 1) const;

private:
    QDomDocument(QDomDocumentPrivate*);

    friend class QDomNode;
};

class Q_XML_EXPORT QDomNamedNodeMap
{
public:
    QDomNamedNodeMap();
    QDomNamedNodeMap(ref const(QDomNamedNodeMap));
    QDomNamedNodeMap& operator= (ref const(QDomNamedNodeMap));
    bool operator== (ref const(QDomNamedNodeMap)) const;
    bool operator!= (ref const(QDomNamedNodeMap)) const;
    ~QDomNamedNodeMap();

    // DOM functions
    QDomNode namedItem(ref const(QString) name) const;
    QDomNode setNamedItem(ref const(QDomNode) newNode);
    QDomNode removeNamedItem(ref const(QString) name);
    QDomNode item(int index) const;
    QDomNode namedItemNS(ref const(QString) nsURI, ref const(QString) localName) const;
    QDomNode setNamedItemNS(ref const(QDomNode) newNode);
    QDomNode removeNamedItemNS(ref const(QString) nsURI, ref const(QString) localName);

    // DOM read only attributes
    int length() const;
    int count() const { return length(); } // Qt API consitancy
    /+inline+/ int size() const { return length(); } // Qt API consistency
    /+inline+/ bool isEmpty() const { return length() == 0; } // Qt API consistency

    // Qt extension
    bool contains(ref const(QString) name) const;

private:
    QDomNamedNodeMapPrivate* impl;
    QDomNamedNodeMap(QDomNamedNodeMapPrivate*);

    friend class QDomNode;
    friend class QDomDocumentType;
    friend class QDomElement;
};

class Q_XML_EXPORT QDomDocumentFragment : public QDomNode
{
public:
    QDomDocumentFragment();
    QDomDocumentFragment(ref const(QDomDocumentFragment) x);
    QDomDocumentFragment& operator= (ref const(QDomDocumentFragment));

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return DocumentFragmentNode; }

private:
    QDomDocumentFragment(QDomDocumentFragmentPrivate*);

    friend class QDomDocument;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomCharacterData : public QDomNode
{
public:
    QDomCharacterData();
    QDomCharacterData(ref const(QDomCharacterData) x);
    QDomCharacterData& operator= (ref const(QDomCharacterData));

    // DOM functions
    QString substringData(unsigned long offset, unsigned long count);
    void appendData(ref const(QString) arg);
    void insertData(unsigned long offset, ref const(QString) arg);
    void deleteData(unsigned long offset, unsigned long count);
    void replaceData(unsigned long offset, unsigned long count, ref const(QString) arg);

    // DOM read only attributes
    int length() const;

    // DOM attributes
    QString data() const;
    void setData(ref const(QString));

    // Overridden from QDomNode
    QDomNode::NodeType nodeType() const;

private:
    QDomCharacterData(QDomCharacterDataPrivate*);

    friend class QDomDocument;
    friend class QDomText;
    friend class QDomComment;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomAttr : public QDomNode
{
public:
    QDomAttr();
    QDomAttr(ref const(QDomAttr) x);
    QDomAttr& operator= (ref const(QDomAttr));

    // DOM read only attributes
    QString name() const;
    bool specified() const;
    QDomElement ownerElement() const;

    // DOM attributes
    QString value() const;
    void setValue(ref const(QString));

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return AttributeNode; }

private:
    QDomAttr(QDomAttrPrivate*);

    friend class QDomDocument;
    friend class QDomElement;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomElement : public QDomNode
{
public:
    QDomElement();
    QDomElement(ref const(QDomElement) x);
    QDomElement& operator= (ref const(QDomElement));

    // DOM functions
    QString attribute(ref const(QString) name, ref const(QString) defValue = QString() ) const;
    void setAttribute(ref const(QString) name, ref const(QString) value);
    void setAttribute(ref const(QString) name, qlonglong value);
    void setAttribute(ref const(QString) name, qulonglong value);
    /+inline+/ void setAttribute(ref const(QString) name, int value)
        { setAttribute(name, qlonglong(value)); }
    /+inline+/ void setAttribute(ref const(QString) name, uint value)
        { setAttribute(name, qulonglong(value)); }
    void setAttribute(ref const(QString) name, float value);
    void setAttribute(ref const(QString) name, double value);
    void removeAttribute(ref const(QString) name);
    QDomAttr attributeNode(ref const(QString) name);
    QDomAttr setAttributeNode(ref const(QDomAttr) newAttr);
    QDomAttr removeAttributeNode(ref const(QDomAttr) oldAttr);
    QDomNodeList elementsByTagName(ref const(QString) tagname) const;
    bool hasAttribute(ref const(QString) name) const;

    QString attributeNS(const QString nsURI, ref const(QString) localName, ref const(QString) defValue = QString()) const;
    void setAttributeNS(const QString nsURI, ref const(QString) qName, ref const(QString) value);
    /+inline+/ void setAttributeNS(const QString nsURI, ref const(QString) qName, int value)
        { setAttributeNS(nsURI, qName, qlonglong(value)); }
    /+inline+/ void setAttributeNS(const QString nsURI, ref const(QString) qName, uint value)
        { setAttributeNS(nsURI, qName, qulonglong(value)); }
    void setAttributeNS(const QString nsURI, ref const(QString) qName, qlonglong value);
    void setAttributeNS(const QString nsURI, ref const(QString) qName, qulonglong value);
    void setAttributeNS(const QString nsURI, ref const(QString) qName, double value);
    void removeAttributeNS(ref const(QString) nsURI, ref const(QString) localName);
    QDomAttr attributeNodeNS(ref const(QString) nsURI, ref const(QString) localName);
    QDomAttr setAttributeNodeNS(ref const(QDomAttr) newAttr);
    QDomNodeList elementsByTagNameNS(ref const(QString) nsURI, ref const(QString) localName) const;
    bool hasAttributeNS(ref const(QString) nsURI, ref const(QString) localName) const;

    // DOM read only attributes
    QString tagName() const;
    void setTagName(ref const(QString) name); // Qt extension

    // Overridden from QDomNode
    QDomNamedNodeMap attributes() const;
    /+inline+/ QDomNode::NodeType nodeType() const { return ElementNode; }

    QString text() const;

private:
    QDomElement(QDomElementPrivate*);

    friend class QDomDocument;
    friend class QDomNode;
    friend class QDomAttr;
};

class Q_XML_EXPORT QDomText : public QDomCharacterData
{
public:
    QDomText();
    QDomText(ref const(QDomText) x);
    QDomText& operator= (ref const(QDomText));

    // DOM functions
    QDomText splitText(int offset);

    // Overridden from QDomCharacterData
    /+inline+/ QDomNode::NodeType nodeType() const { return TextNode; }

private:
    QDomText(QDomTextPrivate*);

    friend class QDomCDATASection;
    friend class QDomDocument;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomComment : public QDomCharacterData
{
public:
    QDomComment();
    QDomComment(ref const(QDomComment) x);
    QDomComment& operator= (ref const(QDomComment));

    // Overridden from QDomCharacterData
    /+inline+/ QDomNode::NodeType nodeType() const { return CommentNode; }

private:
    QDomComment(QDomCommentPrivate*);

    friend class QDomDocument;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomCDATASection : public QDomText
{
public:
    QDomCDATASection();
    QDomCDATASection(ref const(QDomCDATASection) x);
    QDomCDATASection& operator= (ref const(QDomCDATASection));

    // Overridden from QDomText
    /+inline+/ QDomNode::NodeType nodeType() const { return CDATASectionNode; }

private:
    QDomCDATASection(QDomCDATASectionPrivate*);

    friend class QDomDocument;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomNotation : public QDomNode
{
public:
    QDomNotation();
    QDomNotation(ref const(QDomNotation) x);
    QDomNotation& operator= (ref const(QDomNotation));

    // DOM read only attributes
    QString publicId() const;
    QString systemId() const;

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return NotationNode; }

private:
    QDomNotation(QDomNotationPrivate*);

    friend class QDomDocument;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomEntity : public QDomNode
{
public:
    QDomEntity();
    QDomEntity(ref const(QDomEntity) x);
    QDomEntity& operator= (ref const(QDomEntity));

    // DOM read only attributes
    QString publicId() const;
    QString systemId() const;
    QString notationName() const;

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return EntityNode; }

private:
    QDomEntity(QDomEntityPrivate*);

    friend class QDomNode;
};

class Q_XML_EXPORT QDomEntityReference : public QDomNode
{
public:
    QDomEntityReference();
    QDomEntityReference(ref const(QDomEntityReference) x);
    QDomEntityReference& operator= (ref const(QDomEntityReference));

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return EntityReferenceNode; }

private:
    QDomEntityReference(QDomEntityReferencePrivate*);

    friend class QDomDocument;
    friend class QDomNode;
};

class Q_XML_EXPORT QDomProcessingInstruction : public QDomNode
{
public:
    QDomProcessingInstruction();
    QDomProcessingInstruction(ref const(QDomProcessingInstruction) x);
    QDomProcessingInstruction& operator= (ref const(QDomProcessingInstruction));

    // DOM read only attributes
    QString target() const;

    // DOM attributes
    QString data() const;
    void setData(ref const(QString) d);

    // Overridden from QDomNode
    /+inline+/ QDomNode::NodeType nodeType() const { return ProcessingInstructionNode; }

private:
    QDomProcessingInstruction(QDomProcessingInstructionPrivate*);

    friend class QDomDocument;
    friend class QDomNode;
};


Q_XML_EXPORT QTextStream& operator<<(QTextStream&, ref const(QDomNode));

#endif // QT_NO_DOM

QT_END_NAMESPACE

#endif // QDOM_H
