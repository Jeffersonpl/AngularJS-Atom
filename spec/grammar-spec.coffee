describe 'directive grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('angularjs')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.html.angular')

  it 'parses the grammar', ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'text.html.angular'

  describe 'directive attributes', ->
    it 'tokenizes ng-repeat attribute inside HTML', ->
      lines = grammar.tokenizeLines '''
        <dd ng-repeat="availability in phone.availability">{{availability}}</dd>
      '''

      expect(lines[0][3]).toEqual value: 'ng-repeat', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'entity.other.attribute-name.html.angular']

    it 'tokenizes ng-src and ng-click attributes inside HTML', ->
      lines = grammar.tokenizeLines '''
        <li ng-repeat="img in phone.images">
          <img ng-src="{{img}}" ng-click="setImage(img)">
        </li>
      '''

      expect(lines[0][3]).toEqual value: 'ng-repeat', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'entity.other.attribute-name.html.angular']
      expect(lines[1][4]).toEqual value: 'ng-src', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'entity.other.attribute-name.html.angular']
      expect(lines[1][10]).toEqual value: 'ng-click', scopes: ['text.html.angular', 'meta.tag.inline.any.html', 'entity.other.attribute-name.html.angular']

    it 'tokenizes ng-view attribute without value inside HTML', ->
      lines = grammar.tokenizeLines '''
        <div ng-view class="view-frame"></div>
      '''

      expect(lines[0][3]).toEqual value: 'ng-view', scopes: ['text.html.angular', 'meta.tag.block.any.html', 'entity.other.attribute-name.html.angular']