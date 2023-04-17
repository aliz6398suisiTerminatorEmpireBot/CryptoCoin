//Coin
pragma solidity ^0.8.7;
contract coin{
    string _name;
    string _symbol;
    uint256 _totalSupply;
    uint8 _decimals;
    address _owner;
    mapping(address=>uint256) _balances;
    bool _paused;
    constructor(){
        _name="EB Coin";
        _symbol="EBCN";
        _totalSupply=(10**55)*(10**15);
        _decimals=55;
        _owner=msg.sender;
        _balances[_owner]=_totalSupply;
        _paused=false;
    }
    function name() external view returns(string memory){
        return _name;
    }
    function symbol() external view returns(string memory){
        return _symbol;
    }
    function owner() external view returns(address){
        return _owner;
    }
    function getOwner() external view returns(address){
        return _owner;
    }
    function transferOwnership(address addr) external {
        require(msg.sender==_owner,"You'ren't Owner");
        _owner=addr;
    }
    function decimal() external view returns(uint8){
        return _decimals;
    }
    function decimals() external view returns(uint8){
        return _decimals;
    }
    function totalSupply() external view returns(uint256){
        return _totalSupply;
    }
    function balance() external view returns(uint256){
        return _balances[msg.sender];
    }
    function balanceOf(address addr) external view returns(uint256){
        return _balances[addr];
    }
    function transfer(address _to,uint256 _value) external {
        require(!_paused,"Market is closed");
        require(_balances[msg.sender]>=_value,"no money");
        _balances[msg.sender] = _balances[msg.sender] - _value;
        _balances[_to] = _balances[_to] + _value;
    }
    function transferFrom(address _from,address _to,uint256 _value) external {
        require(!_paused,"Market is closed");
        require(_balances[_from]>=_value,"no money");
        _balances[_from] = _balances[_from] - _value;
        _balances[_to] = _balances[_to] + _value;
    }
    function pause() external {
        require(msg.sender==_owner,"You'ren't Owner");
        _paused=true;
    }
    function unpause() external {
        require(msg.sender==_owner,"You'ren't Owner");
        _paused=false;
    }
    function rename(string memory nm) external {
        require(msg.sender==_owner,"You'ren't Owner");
        _name=nm;
    }
    function updateSymbol(string memory sm) external {
        require(msg.sender==_owner,"You'ren't Owner");
        _symbol=sm;
    }
    function updateDecimal(uint8 dec) external {
        require(msg.sender==_owner,"You'ren't Owner");
        _decimals=dec;
    }
    function mint(uint256 value) external {
        require(!_paused,"Market is closed");
        if(msg.sender==_owner){
            _totalSupply = _totalSupply+value;
            _balances[_owner]=_balances[_owner]+value;
        }else{
            require(_balances[msg.sender]>=value,"no money");
            _balances[msg.sender] = _balances[msg.sender]-value;
            _balances[_owner] = _balances[_owner]+value;
        }
    }
    function burn(uint256 value) external {
        require(_balances[msg.sender]>=value,"no money");
        require(!_paused,"Market is closed");
        _balances[msg.sender]=_balances[msg.sender]-value;
        _totalSupply-=value;
    }
    function mintFrom(address addr,uint256 value) external {
        require(!_paused,"Market is closed");
        if(addr==_owner){
            require(msg.sender==_owner,"You'ren't owner");
            _totalSupply=_totalSupply+value;
            _balances[_owner]=_balances[_owner]+value;
        }else{
            require(_balances[addr]>=value,"No money");
            _balances[addr]=_balances[addr]-value;
            _balances[_owner]=_balances[_owner]+value;
        }
    }
    function burnFrom(address addr,uint256 value) external {
        if(addr==_owner){
            require(msg.sender==_owner,"You'ren't Owner");
        }
        require(!_paused,"Market is closed");
        require(_balances[addr]>=value,"no money");
        _balances[addr]=_balances[addr]-value;
        _totalSupply=_totalSupply-value;
    }
}